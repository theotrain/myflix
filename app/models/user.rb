class User < ActiveRecord::Base

  has_secure_password validations: false
  validates :email, presence: true, uniqueness: true
  # validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, presence: true, length: { minimum: 4 }
  validates :full_name, presence: true, length: { minimum: 3 }
end