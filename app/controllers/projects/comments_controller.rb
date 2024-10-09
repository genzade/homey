module Projects
  class CommentsController < ApplicationController
    before_action :set_project

    def new
      create_comment_form = Forms::Projects::CreateCommentForm.new(current_user, @project, {})

      render locals: { create_comment_form: create_comment_form, project: @project }
    end

    def create
      create_comment_form = Forms::Projects::CreateCommentForm.new(
        current_user,
        @project,
        comment_params,
      )

      respond_to do |format|
        if create_comment_form.save
          flash[:notice] = "Comment added successfully"
          format.turbo_stream { render :create, locals: { project: @project } }
        else
          format.html {
            render(
              :new,
              locals: { create_comment_form: create_comment_form, project: @project },
              status: :unprocessable_entity,
            )
          }
        end
      end
    end

    private

    def set_project
      @project ||= Project.find_by(id: params[:project_id])
    end

    def comment_params
      params.require(:forms_projects_create_comment_form).permit(:body)
    end
  end
end
