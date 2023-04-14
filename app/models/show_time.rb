class ShowTime < ApplicationRecord
  has_many :seats, dependent: :restrict_with_exception
  belongs_to :movie
  belongs_to :room

  delegate :cinema_name, to: :room
  delegate :title, to: :movie, prefix: :movie
  delegate :name, to: :room, prefix: :room

  scope :filter_date, lambda{|movie_id, date|
    where "(movie_id = ? AND start_time > ? )",
          movie_id,
          date.to_datetime.beginning_of_day
  }



  ransacker :start_time, type: :date do
    Arel.sql("date(start_time)")
  end

  def self.ransackable_scopes _auth_object = nil
    %i(filter_date)
  end
end
