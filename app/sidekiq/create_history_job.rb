class CreateHistoryJob < BaseJob
  def perform(user_id, trackable_id, trackable_type, tracked_field = nil, tracked_value = nil,
    action)
    user = User.find(user_id)
    trackable = trackable_type.constantize.find(trackable_id)

    ActiveRecord::Base.transaction do
      form = Forms::CreateHistoryForm.new(
        user,
        trackable,
        action: action,
        tracked_field: tracked_field,
        tracked_value: tracked_value,
      )
      form.save
    end
  end
end
