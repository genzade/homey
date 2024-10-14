module Forms
  class CreateHistoryForm < Forms::ApplicationForm
    attr_accessor :user, :trackable, :action, :tracked_field, :tracked_value

    validates :trackable, presence: true
    validates :user, presence: true
    validates :action, presence: true
    validates :tracked_field, presence: true, if: :action_updated?
    validates :tracked_value, presence: true, if: :action_updated?

    def initialize(user, trackable, attributes = {})
      @user = user
      @trackable = trackable
      super(attributes)
    end

    def save
      return false unless valid?

      history.save!

      boradcast_event(history)

      true
    end

    private

    def action_updated?
      action.eql?(History::ACTION_OPTIONS[:updated])
    end

    def history
      @history ||= History.new(
        trackable: trackable,
        user: user,
        action: action,
        tracked_field: tracked_field,
        tracked_value: tracked_value,
      )
    end

    def boradcast_event(history)
      history.broadcast_prepend_to(
        "histories",
        partial: "projects/histories/history",
        locals: { history: history },
        target: "history_list",
      )
    end
  end
end
