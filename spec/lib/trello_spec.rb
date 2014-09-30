# We only test or our code make the right http calls
require 'spec_helper'

describe "Trello" do
  let(:user) {User.new(:id => 1, :authentication_token => "secret", :project_id => 666)}

  describe "get projects" do
    it "makes a GET request to /members/me/boards" do
      stub_request(:get, "https://api.trello.com/1/members/me/boards?key=trello_app_id&token=secret")
      expect{Trello::User.new(user).projects}.to raise_error
    end
  end

  describe "get tasklists" do
    it "makes a GET request /boards/666/lists" do
      stub_request(:get, "https://api.trello.com/1/boards/666/lists?key=trello_app_id&token=secret")
      expect{Trello::User.new(user).tasklists}.to raise_error
    end
  end

  describe "get profile" do
    it "makes a GET request to /me" do
      stub_request(:get, "https://api.trello.com/1/members/me/boards?key=trello_app_id&token=secret")
      expect{Trello::User.new(user).me}.to raise_error
    end
  end

  describe "create Trello task" do
    it "makes a post request to /cards" do
      data = {
        :project_id => 666,
        :tasklist_id => 666,
        :name => "Test todo",
        :description => "Desc"
      }
      stub_request(:post, "https://api.trello.com/1/cards").
         with(:body => "desc=Desc&due=&idList=666&key=trello_app_id&name=Test+todo&pos=top&token=secret")
      Trello::User.new(user).create_task(data)
    end
  end

  describe "Trello::Task.create" do
    it "returns a Trello hash to create a task" do
      data = {
          :project_id => 666,
          :tasklist_id => 666,
          :name => "Test todo",
          :description => "Desc"
      }
      response = Trello::Task.create(data)
      expect(response.class).to eq(Hash)
      expect(response.keys).to eq(["idList", "name", "desc", "due", "pos"])
    end
  end
end