module Redbooth
  class User < API::User
    def initialize(user)
      @client = Redbooth::Client.new({:token => user.authentication_token})
    end

    def me
      @client.get("me")
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
      @client.get("projects").collect do |task|
        Redbooth::Project.new(task)
      end
    end

    def create_task(data)
      @client.post("tasks", Redbooth::Task.create(data))
    end
  end
end