class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  validates :name, length: { maximum: 100 }

  normalizes :email, with: ->(email) { email.strip.downcase }
  normalizes :name, with: ->(name) { name&.strip }
end
