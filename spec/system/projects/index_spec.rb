require "rails_helper"

RSpec.describe "Projects::Index", type: :system do
  context "when visiting the project index page" do
    it "displays a list of projects with their status" do
      create(:project, name: "Project 1", status: "ignition")
      create(:project, name: "Project 2", status: "in_progress")
      create(:project, name: "Project 3", status: "completed")

      visit(projects_path)

      expect(page).to have_content("Project 1")
      expect(page).to have_content("ignition")
      expect(page).to have_content("Project 2")
      expect(page).to have_content("in_progress")
      expect(page).to have_content("Project 3")
      expect(page).to have_content("completed")
    end

    it "displays a link to project show page" do
      project = create(:project, name: "Project 1", status: "ignition")

      visit(projects_path)

      expect(page).to have_link("Show", href: project_path(project))
    end
  end
end