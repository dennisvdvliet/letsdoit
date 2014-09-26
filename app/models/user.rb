class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:redbooth]

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
    user.update_attributes(authentication_token: auth.credentials.token, token_expires_at: Time.at(auth.credentials.expires_at).to_datetime)
    user
  end

  def tasks
    api.tasks
  end

  def tasklists
    api.tasks
  end

  def projects
    api.tasks
  end

  def me
    api.me
  end
  def api
    @api ||= API::User.new(self)
  end
end
