module API
  class User
    def initialize(user)
      case user.provider
      when 'redbooth'
        @user = Redbooth::User.new(user)
      else
        raise "No such provider"
      end
      return @user
    end

    def me
      @user.me
    end

    def tasklists
      @user.tasklists
    end

    def tasks
      @user.tasks
    end
  end
end