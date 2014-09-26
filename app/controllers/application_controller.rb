class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def api
    case current_user.provider
    when 'redbooth'
      redbooth_api
    else
      raise "API not yet implemented"
    end
  end

  def redbooth_api
    Redbooth::API.new({token: current_user.authentication_token})
  end
end
