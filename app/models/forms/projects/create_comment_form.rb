module Forms
  module Projects
    class CreateCommentForm < Forms::ApplicationForm
      attr_accessor :body

      validates :body, presence: true
      validate :user_must_be_logged_in

      def initialize(user, project, attributes = {})
        @user = user
        @project = project
        super(attributes)
      end

      def save
        return false unless valid?

        comment.save!

        create_history

        true
      end

      private

      attr_reader :user, :project

      def user_must_be_logged_in
        return if user.present?
        errors.add(:base, "You must be logged in to leave a comment")
      end

      def comment
        @comment ||= Comment.new(
          body: body,
          user: user,
          project: project,
          # parent: parent,
        )
      end

      def create_history
        CreateHistoryJob.perform_async(
          user.id,
          comment.id,
          "Comment",
          History::ACTION_OPTIONS[:created],
        )
      end
    end
  end
end
