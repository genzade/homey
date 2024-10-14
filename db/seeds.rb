# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.find_or_create_by!(email: "test@mail.com") do |user|
  user.password = "asdfasdf"
  user.save!
end

10.times do |i|
  Project.find_or_create_by!(name: "Super Awesome Project #{i + 1}")
end

30.times do |i|
  user = User.find_or_create_by!(email: "test#{i + 1}@mail.com") do |user|
    user.password = "asdfasdf"
    user.save!

    project = Project.find(Project.ids.sample)
    udpate_project_form = Forms::UpdateProjectForm.new(
      project,
      user,
      name: "Just An Awesome Project #{rand(100)}",
    )
    udpate_project_form.save

    comment_form = Forms::Projects::CreateCommentForm.new(
      user,
      Project.find(Project.ids.sample),
      body: "comment body",
    )
    comment_form.save

    project = Project.find(Project.ids.sample)
    new_status = (Project.statuses.keys - [ project.status ]).sample
    udpate_project_form = Forms::UpdateProjectForm.new(
      project,
      user,
      status: new_status,
    )
    udpate_project_form.save
  end
end
