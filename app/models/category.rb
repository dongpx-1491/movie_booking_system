class Category < ApplicationRecord
  has_many :movie_categories, dependent: :destroy
  has_many :movies, through: :movie_categories

  validates :name, presence: true,
  length: {maximum: 50},
  uniqueness: true

  scope :asc_name, ->{order name: :asc}
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
