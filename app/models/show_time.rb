class ShowTime < ApplicationRecord
  has_many :seats, dependent: :restrict_with_exception
  belongs_to :movie
  belongs_to :room

  delegate :cinema_name, to: :room
  delegate :title, to: :movie, prefix: :movie
  delegate :name, to: :room, prefix: :room
end
