# We only test or our code make the right http calls
require 'spec_helper'

describe "Redbooth" do
  let(:user) {User.new(:id => 1, :authentication_token => "secret", :project_id => 666)}

  describe "get projects" do
    it "makes a GET request to /projects" do
      stub_request(:get, "https://redbooth.com/api/3/projects").
         with(:headers => {'Authorization'=>'Bearer secret'})
      expect{Redbooth::User.new(user).projects}.to raise_error
    end
  end

  describe "get tasklists" do
    it "makes a GET request /task_lists" do
      stub_request(:get, "https://redbooth.com/api/3/task_lists").
         with(:headers => {'Authorization'=>'Bearer secret'})
      expect{Redbooth::User.new(user).tasklists}.to raise_error
    end
  end

  describe "get profile" do
    it "makes a GET request to /me" do
      stub_request(:get, "https://redbooth.com/api/3/me").
         with(:headers => {'Authorization'=>'Bearer secret'})
      Redbooth::User.new(user).me
    end
  end

  describe "create Redbooth task" do
    it "makes a post request to /tasks" do
      data = {
        :project_id => 666,
        :tasklist_id => 666,
        :name => "Test todo",
        :description => "Desc"
      }
      stub_request(:post, "https://redbooth.com/api/3/tasks").
         with(:body => "{\"project_id\":666,\"task_list_id\":666,\"name\":\"Test todo\",\"description\":\"Desc\"}")
      Redbooth::User.new(user).create_task(data)
    end
  end

  describe "Redbooth::Task.create" do
    it "returns a Redbooth hash to create a task" do
      data = {
          :project_id => 666,
          :tasklist_id => 666,
          :name => "Test todo",
          :description => "Desc"
      }
      response = Redbooth::Task.create(data)
      expect(response.class).to eq(String)
      expect{JSON.parse(response)}.to_not raise_error
    end
  end
end