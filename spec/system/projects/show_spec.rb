require "rails_helper"

RSpec.describe "Projects::Show", type: :system do
  context "when visiting the project show page" do
    context "when not logged in" do
      it "displays all comments and status changes" do
        project = create(:project, name: "Project 1", status: "ignition")
        user = create(:user)

        create(:comment, user: user, project: project, body: "This is a comment")

        visit(project_path(project))

        expect(page).to have_content("Project 1")
        expect(page).to have_content("Ignition")
        expect(page).to have_content("This is a comment")
      end
    end

    context "when logged in" do
      it "user can leave a comment, displays all comments and status changes", :sidekiq_inline do
        user = create(:user)
        project = create(:project, name: "Project 1", status: "ignition")

        sign_in_with(user.email, user.password)

        visit(project_path(project))

        fill_in("forms_projects_create_comment_form_body", with: "This is a new comment")

        click_button("Add Comment")

        expect(page).to have_content("This is a new comment")
        expect(page).to have_content("by #{user.email}")
      end

      it "only a user associated with a project can change the status of a project" do
        project = create(:project, name: "Project 1", status: "ignition")
        user = project.users.first

        sign_in_with(user.email, "MyPassword")

        sleep(1)
        visit(project_path(project))

        sleep(1)
        select("In progress", from: "forms_update_project_form_status")

        sleep(1)
        sleep(1)
        sleep(1)
        sleep(1)
        expect(page).to have_content("#{user.email} updated status from ignition to in_progress")
      end
    end
  end
end
