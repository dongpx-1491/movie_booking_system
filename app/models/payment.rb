class Payment < ApplicationRecord
  attr_accessor :activation_token

  has_many :tickets, dependent: :destroy
  belongs_to :user
  enum status: {inactive: 0, active: 1}

  scope :sort_list, ->{order created_at: :desc}
  scope :latest, ->{order activated_at: :desc}
  scope :show_active, ->{where status: :active}
  scope :incre_order, ->{order(status: :asc, created_at: :desc)}
  scope :check_expire, (lambda do |id, created_at|
    where("id = #{id} AND
      timestampdiff(second,
        DATE_FORMAT('#{created_at}', '%Y-%m-%d %T.%f'),
        '#{Time.zone.now}') < 600
      AND status = 0")
  end)

  delegate :user_name, :phone, to: :user, prefix: :user

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

  ransacker :created_at, type: :date do
    Arel.sql("date(created_at at time zone 'UTC' at time zone 'Hanoi')")
  end

  def self.ransackable_associations(auth_object = nil)
    ["tickets", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["activated_at", "activation_digest", "created_at", "id", "status", "total_cost", "updated_at", "user_id"]
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
