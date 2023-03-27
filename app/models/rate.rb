class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :comment, length: {maximum: Settings.digits.length_cmt_max}
end
