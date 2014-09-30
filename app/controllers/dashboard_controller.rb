class DashboardController < ApplicationController

  def show
    respond_to do |format|
      format.html
      format.json  {render :json => @hashtag}
    end
  end

  def update
    current_user.update_attributes(user_params)
    redirect_to next_step
  end

  private
    def user_params
      params.permit(:tasklist_id, :project_id)
    end

    def next_step
      return projects_path if current_user.project_id.nil?
      return tasklists_path if current_user.tasklist_id.nil?
      dashboard_path
    end
end
