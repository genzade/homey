require 'rails_helper'

RSpec.describe Forms::UpdateProjectForm, type: :model do
  describe "#save" do
    context "when the form is valid" do
      it "updates project, returns true" do
        project = create(:project)
        user = create(:user)
        form = Forms::UpdateProjectForm.new(
          project,
          user,
          name: "New Name",
          status: Project::STATUS_OPTIONS[:in_progress],
        )

        expect do
          expect(form.save).to be(true)
          expect(form.errors).to be_empty
        end.to change { Project.all }
          .from(
            a_collection_containing_exactly(
              an_object_having_attributes(
                name: project.name,
                status: Project::STATUS_OPTIONS[:ignition],
              ),
            ),
          )
          .to(
            a_collection_containing_exactly(
              an_object_having_attributes(
                name: "New Name",
                status: Project::STATUS_OPTIONS[:in_progress],
              ),
            ),
          )
          .and enqueue_sidekiq_job(CreateHistoryJob)
          .with(
            user.id,
            a_value,
            "Project",
            "status",
            Project::STATUS_OPTIONS[:in_progress],
            History::ACTION_OPTIONS[:updated],
          )
          .and enqueue_sidekiq_job(CreateHistoryJob)
          .with(
            user.id,
            a_value,
            "Project",
            "name",
            "New Name",
            History::ACTION_OPTIONS[:updated],
          )
      end
    end

    context "when the form is invalid" do
      it "does not update project, returns false" do
        project = create(:project)
        form = Forms::UpdateProjectForm.new(
          project,
          nil,
          status: "invalid",
        )

        expect do
          expect(form.save).to be(false)
          expect(form.errors.full_messages).to include(
            "Status is not included in the list",
            "You must be logged in to update a project",
          )
        end.not_to change { project.status }
      end
    end
  end
end
