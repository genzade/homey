module Trackable
  extend ActiveSupport::Concern

  included do
    has_many :histories, as: :trackable, dependent: :destroy
  end
end
