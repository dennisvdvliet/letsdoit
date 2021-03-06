module Trello
  class User < API::User
    def initialize(user)
      @client = Trello::Client.new({:token => user.authentication_token})
      @user = user
    end

    def me
      @client.get("members/me")
    end

    def tasklists
      @client.get("boards/#{@user.project_id}/lists").collect do |tasklist|
        Trello::Tasklist.new(tasklist)
      end
    end

    def projects
      @client.get("members/me/boards").collect do |task|
        Trello::Project.new(task)
      end
    end

    def create_task(data)
      @client.post("cards", Trello::Task.create(data))
    end
  end
end