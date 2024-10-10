class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update]

  def index
    @projects = Project.all

    render locals: { projects: @projects }
  end

  def show
    render locals: { project: @project }
  end

  def edit
    update_project_form = Forms::UpdateProjectForm.new(@project, current_user, {})
    render locals: { update_project_form: update_project_form, project: @project }
  end

  def update
    update_project_form = Forms::UpdateProjectForm.new(@project, current_user, project_params)
    respond_to do |format|
      if update_project_form.save
        flash[:notice] = "Project updated successfully"
        format.turbo_stream { render :update, locals: { project: @project } }
      else
        format.html do
          render(
            :edit,
            locals: { update_project_form: update_project_form, project: @project },
            status: :unprocessable_entity,
          )
        end
      end
    end
  end

  private

  def set_project
    @project ||= Project.find_by(id: params[:id])
  end

  def project_params
    params.require(:forms_update_project_form).permit(:status, :name)
  end
end
