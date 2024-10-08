class Project < ApplicationRecord
  STATUS_OPTIONS = {
    ignition: "ignition",
    in_progress: "in_progress",
    completed: "completed",
  }.freeze

  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  has_many :comments, inverse_of: :project, dependent: :destroy

  validates :name, presence: true

  enum :status, STATUS_OPTIONS, default: :ignition
end
