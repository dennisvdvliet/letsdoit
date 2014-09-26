module Trello
  class User < API::User
    def initialize(user)
      @client = Trello::Client.new({:token => user.authentication_token})
    end

    def me
      @client.get("members/me")
    end

    def tasklists
      @client.get("task_lists").collect do |tasklist|
        Redbooth::Tasklist.new(tasklist)
      end
    end

    def tasks
      @client.get("tasks").collect do |task|
        Redbooth::Task.new(task)
      end
    end

    def projects
      @client.get("members/me/boards").collect do |task|
        Trello::Project.new(task)
      end
    end
  end
end