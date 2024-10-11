class History < ApplicationRecord
  ACTION_OPTIONS = {
    created: "created",
    updated: "updated",
    deleted: "deleted",
  }.freeze

  belongs_to :trackable, polymorphic: true
  belongs_to :user

  enum :action, ACTION_OPTIONS
end
