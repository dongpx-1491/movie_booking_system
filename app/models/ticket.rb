class Ticket < ApplicationRecord
  belongs_to :payment, optional: true
  belongs_to :show_time
end
