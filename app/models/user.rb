class User < ApplicationRecord
  has_secure_password

  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users

  validates :email, presence: true, uniqueness: true
  normalizes :email, with: ->(email) { email.strip.downcase }
end
