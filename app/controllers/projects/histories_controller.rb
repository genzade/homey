module Projects
  class HistoriesController < ApplicationController
    before_action :set_project

    def index
      histories = project_histories.or(comment_histories).order(created_at: :desc).limit(10)

      respond_to do |format|
        format.html do
          if turbo_frame_request?
            render :index, locals: { project: @project, histories: histories }
          else
            render locals: { project: @project, histories: histories }
          end
        end
      end
    end

    private

    def set_project
      @project = Project.find(params[:project_id])
    end

    def project_histories
      History.includes(:user, :trackable).by_trackable(@project)
    end

    def comment_histories
      History.by_trackable(@project.comments)
    end
  end
end
