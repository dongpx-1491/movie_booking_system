class Movie < ApplicationRecord
  include ImageUploader[:image]
  include BannerUploader[:banner]

  MOVIE_ATTRS = %i(title description rating image banner
    duration_min release_time language
    director cast age_range).freeze

  has_many :rates, dependent: :destroy
  has_many :show_times, dependent: :destroy
  has_many :movie_categories, dependent: :destroy
  has_many :categories, through: :movie_categories
  has_many :tickets, through: :show_times

  accepts_nested_attributes_for :movie_categories

  enum status: {inactive: 0, active: 1}
  MOVIE_ATTRS = %i(title description rating img_link
    duration_min release_time language
    director cast age_range category_id).freeze

  validates :title, presence: true,
  length: {maximum: 50}
  validates :description, presence: true,
  length: {maximum: 550}
  validates :release_time, presence: true,
  date: {after: proc{Time.zone.now}}, on: :save

  delegate :name, to: :category, prefix: true
  ransack_alias :categories, :categories_name
  scope :sort_list, ->{order release_time: :desc}
  scope :is_release, ->{where "release_time <= ?", Time.zone.now }
  scope :not_release, ->{where "release_time > ?", Time.zone.now }
  scope :now_showing, ->{joins(:show_times).group('show_times.id').having('min(show_times.start_time) <= ?', Time.zone.now)}
  scope :coming_soon, ->{joins(:show_times).group('show_times.id').having('min(show_times.start_time) <= ?', Time.zone.now)}
  scope :incre_order, ->{order(id: :asc)}
  scope :top_seller, ->{order(revenue: :desc)}
  scope :by_month, ->(month){where("MONTH(release_time) = ?", month)}

  def self.ransackable_attributes(auth_object = nil)
    ["age_range", "cast", "categories", "revenue", "created_at", "description", "director", "duration_min", "id", "img_link", "language", "rating", "release_time", "status", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["categories", "image_attachment", "image_blob", "movie_categories", "rates", "show_times"]
  end

  def update_revenue
    total = 0
    tickets.each{|ticket|
     total += ticket.show_time_price if ticket.payment.active?}
    update_attribute :revenue, total
  end
end
