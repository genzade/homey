class ProjectsController < ApplicationController
  def index
    @projects = Project.all

    render locals: { projects: @projects }
  end
end
