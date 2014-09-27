class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :active_user?
  def redbooth
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in @user
    redirect_to projects_path
  end

  def trello
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in @user
    redirect_to projects_path
  end
end