class User < ApplicationRecord
  USER_ATTRS = %i(user_name date_birth phone email password
    password_confirmation).freeze
  before_save :downcase_email

  has_many :rates, dependent: :destroy
  has_many :payments, dependent: :destroy

  enum :role, {customer: 0, admin: 1}
  validates :user_name, presence: true,
            length: {maximum: Settings.digits.length_name_max_50}

  validates :email, presence: true,
            length: {maximum: Settings.digits.length_email_max_255},
            format: {with: Settings.regex.email},
            uniqueness: true

  validates :password, presence: true,
            length: {minimum: Settings.digits.length_password_min_6},
            if: :password

  validates :phone, presence: true,
          length: {is: Settings.digits.length_phone_number},
          uniqueness: true

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
