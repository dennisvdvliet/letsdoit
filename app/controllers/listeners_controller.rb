class ListenersController < ApplicationController

  def index
    render :json => {:env => ENV}
  end
end
