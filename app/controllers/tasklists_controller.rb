class TasklistsController < ApplicationController

  def index
    render :json => api.get("me")
  end
end
