class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, confirmation: true

  before_create :generate_api_key

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end
end
