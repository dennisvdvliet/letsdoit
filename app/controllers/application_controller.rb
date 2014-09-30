class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :active_user?
  before_filter :set_hashtag

  def set_hashtag
    @hashtag = ENV["LISTEN_TO"] || "none"
  end

  def active_user?
    if current_user && current_user.active? == false
      # ugly hack for Trello
      case current_user.provider
      when 'trello'
        redirect_to "/users/auth/trello" and return
      else
        redirect_to user_omniauth_authorize_path(current_user.provider) and return
      end
    end
  end
end
