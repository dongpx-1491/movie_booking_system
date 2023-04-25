class Movie < ApplicationRecord
  has_many :rates, dependent: :destroy
  has_many :show_times, dependent: :destroy
  has_many :movie_categories, dependent: :destroy
  has_many :categories, through: :movie_categories
  has_one_attached :image

  accepts_nested_attributes_for :movie_categories

  enum status: {inactive: 0, active: 1}

  delegate :name, to: :category, prefix: true
  ransack_alias :categories, :categories_name
  scope :sort_list, ->{order release_time: :desc}
  scope :is_release, ->{where "release_time <= ?", Time.zone.now }
  scope :not_release, ->{where "release_time > ?", Time.zone.now }
  scope :now_showing, ->{joins(:show_times).group('show_times.id').having('min(show_times.start_time) <= ?', Time.zone.now)}
  scope :coming_soon, ->{joins(:show_times).group('show_times.id').having('min(show_times.start_time) <= ?', Time.zone.now)}


  def self.ransackable_attributes(auth_object = nil)
    ["age_range", "cast", "categories", "created_at", "description", "director", "duration_min", "id", "img_link", "language", "rating", "release_time", "status", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["categories", "image_attachment", "image_blob", "movie_categories", "rates", "show_times"]
  end
end
