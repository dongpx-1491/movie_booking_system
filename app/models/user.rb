class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token

  USER_ATTRS = %i(user_name dob phone email password
    password_confirmation).freeze
  before_save :downcase_email
  before_create :create_activation_digest

  has_many :rates, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :movies, through: :favorites

  enum :role, {customer: 0, admin: 1}
  validates :user_name, presence: true,
            length: {maximum: Settings.digits.length_name_max_50}

  validates :email, presence: true,
            length: {maximum: Settings.digits.length_email_max_255},
            format: {with: Settings.regex.email},
            uniqueness: true

  validates :password, presence: true,
            length: {minimum: Settings.digits.length_password_min_6},
            if: :password

  validates :phone, presence: true,
          length: {is: Settings.digits.length_phone_number},
          uniqueness: true

  has_secure_password

  scope :incre_order, ->{order(id: :asc)}

  def self.ransackable_attributes(auth_object = nil)
    ["activated", "activated_at", "activation_digest", "created_at", "dob", "email", "id", "password_digest", "phone", "remember_digest", "reset_digest", "reset_sent_at", "role", "updated_at", "user_name"]
  end
  
  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.blank?

    BCrypt::Password.new(digest).is_password? token
  end

  def activate
    update_attribute :activated, true
    touch :activated_at
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute :reset_digest, User.digest(reset_token)
    touch :reset_sent_at
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.user.email.expired.hours.ago
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
