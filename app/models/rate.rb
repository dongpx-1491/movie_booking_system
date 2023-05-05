class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :comment, presence: true,
           length: {maximum: Settings.rating.comment.max_length}

  delegate :user_name, to: :user, prefix: :user

  scope :latest, ->{order(created_at: :desc)}
  scope :top_five, ->{limit 5}
end
