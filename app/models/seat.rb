class Seat < ApplicationRecord
  belongs_to :show_time
  has_one :ticket, dependent: :destroy

  enum status: {available: 1, choosen: 2, unavailable: 3}
  enum seat_type: {standard: 1, vip: 2}
  
  delegate :start_time, to: :show_time
end
