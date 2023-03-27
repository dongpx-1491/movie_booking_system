class Movie < ApplicationRecord
  has_many :rates, dependent: :destroy
  has_many :show_times, dependent: :destroy
  belongs_to :category
  has_one_attached :image

  delegate :name, to: :category, prefix: true
  scope :sort_list, ->{order :release_time}
end
