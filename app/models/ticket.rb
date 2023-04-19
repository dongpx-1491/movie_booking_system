class Ticket < ApplicationRecord
  belongs_to :payment, optional: true
  belongs_to :show_time

  delegate :start_time, :price, :movie, :room, to: :show_time, prefix: true
end
