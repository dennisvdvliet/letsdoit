class DashboardController < ApplicationController

  def show

  end

  def update
    current_user.update_attributes(user_params)
    redirect_to dashboard_path
  end

  private
    def user_params
      params.permit(:tasklist_id, :project_id)
    end
end
