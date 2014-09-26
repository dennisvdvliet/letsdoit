class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def redbooth
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in @user
      redirect_to tasklists_path
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      render :text => "created new user"
    end
  end
end