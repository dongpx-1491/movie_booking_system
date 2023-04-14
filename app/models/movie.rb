class Movie < ApplicationRecord
  has_many :rates, dependent: :destroy
  has_many :show_times, dependent: :destroy
  has_many :movie_categories, dependent: :destroy
  has_many :categories, through: :movie_categories
  has_one_attached :image

  accepts_nested_attributes_for :movie_categories

  enum status: {inactive: 0, active: 1}

  delegate :name, to: :category, prefix: true
  scope :sort_list, ->{order release_time: :desc}
end
