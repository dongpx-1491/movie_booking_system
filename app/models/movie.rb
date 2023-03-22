class Movie < ApplicationRecord
  has_many :rates, :show_times, dependent: :destroy
  belongs_to :category
end
