module API
  class User
    def initialize(user)
      case user.provider
      when 'redbooth'
        @user = Redbooth::User.new(user)
      when 'trello'
        @user = Trello::User.new(user)
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

    def projects
      @user.projects
    end

    def create_task(data)
      @user.create_task(data)
    end
  end
end