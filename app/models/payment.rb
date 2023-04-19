class Payment < ApplicationRecord
  attr_accessor :activation_token

  has_many :tickets, dependent: :destroy
  belongs_to :user
  enum status: {inactive: 0, active: 1}

  scope :sort_list, ->{order created_at: :desc}
  scope :latest, ->{order activated_at: :desc}
  scope :show_active, ->{where status: :active}

  delegate :user_name, to: :user

  def send_activation_email
    PaymentMailer.payment_activation(self).deliver_now
  end

  def activate_payment
    update_attribute :status, :active
    touch :activated_at
  end

  def authenticated? activation_token
    return false unless activation_token

    BCrypt::Password.new(activation_digest).is_password? activation_token
  end

  def create_activation_digest
    self.activation_token = Payment.new_token
    activation_digest = Payment.digest activation_token
    update_attribute :activation_digest, activation_digest
  end

  def payment_expired?
    created_at < Settings.payment.expired.minutes.ago && inactive?
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
end
