class TasklistsController < ApplicationController

  def index
    respond_to do |format|
      format.json { render :json => current_user.projects }
      format.html
    end
  end
end
