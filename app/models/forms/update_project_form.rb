module Forms
  class UpdateProjectForm < Forms::ApplicationForm
    attr_accessor :name, :status

    validates :status,
      inclusion: { in: Project::STATUS_OPTIONS.values }, allow_blank: true
    validates :name, presence: false
    validate :user_must_be_logged_in

    def initialize(project, user, attributes = {})
      @user = user
      @project = project
      super(attributes)
    end

    def save
      return false unless valid?

      project.assign_attributes(update_params)
      project.save!

      true
    end

    private

    attr_reader :user, :project

    def user_must_be_logged_in
      return if user.present?
      errors.add(:base, "You must be logged in to update a project")
    end

    def update_params
      { name: name, status: status }.compact
    end
  end
end
