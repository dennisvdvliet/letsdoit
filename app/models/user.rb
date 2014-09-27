class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:redbooth]

  scope :active, -> { where.not(project_id: nil, tasklist_id: nil, authentication_token: nil).where("token_expires_at >= ?", Time.now) }

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
    user.update_attributes(
      project_id: nil,
      tasklist_id: nil,
      authentication_token: auth.credentials.token,
      token_expires_at: auth.credentials.expires_at ? Time.at(auth.credentials.expires_at) : Time.now + 2.hours)
    user
  end

  def tasks
    api.tasks
  end

  def tasklists
    api.tasklists
  end

  def projects
    api.projects
  end

  def me
    api.me
  end

  def active?
    token_expires_at != nil && token_expires_at > Time.now
  end

  def api
    @api ||= API::User.new(self)
  end
end
