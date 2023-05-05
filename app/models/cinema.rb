class Cinema < ApplicationRecord
  has_many :rooms, dependent: :destroy
  accepts_nested_attributes_for :rooms, allow_destroy: true
  validates :name, :location, presence: true

  scope :asc_name, ->{order name: :asc}

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "location", "name", "updated_at"]
    end
    
  class << self
    def grouped_options
      all.map do |cinema|
        [cinema.name, cinema.rooms.pluck(:name, :id)]
      end
    end

    def get_info
      cinema_hash = Hash.new
      Cinema.all.find_each do |ci|
        cinema_hash[ci] = Hash.new
        rooms = ci.rooms
        rooms.each do |ro|
          cinema_hash[ci][ro] = Hash.new
          cinema_hash[ci][ro] = ro.show_times
        end
      end
      cinema_hash
    end
  end
end
