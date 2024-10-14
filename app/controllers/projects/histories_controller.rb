module Projects
  class HistoriesController < ApplicationController
    before_action :set_project

    def index
      histories = project_histories.or(comment_histories).order(created_at: :desc).limit(10)

      render locals: { project: @project, histories: histories }
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
