class ShowTime < ApplicationRecord
  SHOW_ATTR = %i(price start_time movie_id room_id end_time).freeze

  has_many :tickets, dependent: :restrict_with_exception
  belongs_to :movie
  belongs_to :room

  before_validation :update_end_time
  validates :start_time, :price, :movie_id, :room_id, presence: true
  validate :valid_overlap_showtime, :valid_start_time

  delegate :cinema_name, to: :room
  delegate :title, to: :movie, prefix: :movie
  delegate :name, to: :room, prefix: :room

  scope :filter_date, lambda{|movie_id, date|
    where "(movie_id = ? AND start_time > ? AND start_time < ?)",
          movie_id,
          Time.now,
          date.to_datetime.end_of_day
  }
  scope :date_available, (lambda do
    where("start_time < AND start_time > ?", DateTime.now.end_of_day, Time.now)
  end)
  scope :not_out_of_date, ->{ where "(end_time > ? )", Time.now.beginning_of_day }
  scope :incre_order, ->{order id: :asc}
  scope :find_room, ->(room_id){where "room_id = ?", room_id}
  scope :by_month, ->(month){where("MONTH(start_time) = ?", month)}
  scope :overlap, lambda {|start_time, end_time|
                    where "((start_time <= ? AND end_time > ?)
                            OR (end_time >= ? AND start_time < ?)
                            OR (start_time >= ? AND end_time <= ?)
                            )",
                          end_time + 5.minutes, end_time + 5.minutes,
                          start_time - 5.minutes, start_time - 5.minutes,
                          start_time - 5.minutes, end_time + 5.minutes
                  }

  ransacker :start_time, type: :date do
    Arel.sql("date(start_time)")
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "end_time", "id", "movie_id", "price", "room_id", "start_time", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["movie", "room", "tickets"]
  end

  def valid_overlap_showtime
    return if ShowTime.find_room(room_id).overlap(start_time, end_time).blank?

    errors.add(:start_time, message: I18n.t("time_overlap"))
  end

  def valid_start_time
    return if start_time > (Time.now + 1.days)

    errors.add(:start_time, message: I18n.t("time_less_than"))
  end

  def self.ransackable_scopes _auth_object = nil
    %i(filter_date)
  end

  def update_end_time
    self.end_time = start_time + movie.duration_min.minutes
  end
end
