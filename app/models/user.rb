class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :payments, dependent: :destroy

  enum sex: {male: 0, female: 1}

  validates :user_name, presence: true,
            length: {maximum: Settings.digits.length_name_max_50}

  validates :email, presence: true,
            length: {maximum: Settings.digits.length_email_max_255},
            format: {with: Settings.regex.email},
            uniqueness: true

  validates :password, presence: true,
            length: {minimum: Settings.digits.length_password_min_6},
            allow_nil: true

  validates :phone, presence: true,
          length: {is: Settings.digits.length_phone_number},
          uniqueness: true

  has_secure_password
end
