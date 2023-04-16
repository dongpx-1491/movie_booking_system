class Payment < ApplicationRecord
  has_many :tickets, dependent: :destroy
  belongs_to :user
  enum status: {inactive: 0, active: 1}

  scope :sort_list, ->{order created_at: :desc}
  delegate :user_name, to: :user

  def payment_expired?
    created_at < Settings.payment.expired.minutes.ago
  end
end
