class User < ApplicationRecord
  has_secure_password

  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
  has_many :comments, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  normalizes :email, with: ->(email) { email.strip.downcase }
end
