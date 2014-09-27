class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :active_user?
  def redbooth
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in @user
    redirect_to tasklists_path
  end

  def trello
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in @user
    redirect_to tasklists_path
  end
end