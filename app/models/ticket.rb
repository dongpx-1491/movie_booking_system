class Ticket < ApplicationRecord
  belongs_to :payment, optional: true
  belongs_to :show_time

  delegate :start_time, :price, :movie, :room, to: :show_time, prefix: true
  validates :seat_position, uniqueness: {scope: :show_time_id}
  scope :by_month, ->(month){where("MONTH(created_at) = ?", month)}
end
