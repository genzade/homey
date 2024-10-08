class ProjectsController < ApplicationController
  def index
    @projects = Project.all

    render locals: { projects: @projects }
  end

  def show
    @project = Project.find(params[:id])
    render locals: { project: @project }
  end
end
