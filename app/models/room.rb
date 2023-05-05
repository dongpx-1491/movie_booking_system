class Room < ApplicationRecord
  has_many :show_times
  belongs_to :cinema

  before_destroy :valid_change
  validates :name, presence: true
  validates :row, :length, presence: true, numericality: {less_than: 11}

  delegate :name, to: :cinema, prefix: :cinema

  def valid_change
    return if show_times.blank?

    errors.add(:show_times, message: I18n.t("show_times_present"))
  end

  def self.ransackable_attributes(auth_object = nil)
    ["cinema_id", "created_at", "id", "length", "name", "row", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["cinema", "show_times"]
  end
end
