class Project < ApplicationRecord
  STATUS_OPTIONS = {
    ignition: "ignition",
    in_progress: "in_progress",
    completed: "completed",
  }.freeze

  validates :name, presence: true

  enum :status, STATUS_OPTIONS, default: :ignition
end
