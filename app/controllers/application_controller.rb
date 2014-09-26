class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :active_user?

  def active_user?
    if current_user && current_user.active? == false
      redirect_to user_omniauth_authorize_path(current_user.provider)
    end
  end
end
