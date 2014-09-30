# We only test or our code make the right http calls
require 'spec_helper'

describe "TaskFromTweet" do
  it "Posts a task to Trello" do
    user = User.new(id: 1, project_id: 1234, tasklist_id: 5678, authentication_token: 'awesome', provider: "trello")
    tweet = double("Tweet", uri: "http://twitter.com/facebook/1234", text: "Awesome tweet")
    stub_request(:post, "https://api.trello.com/1/cards")
    TaskFromTweet.call(user, tweet)
  end
end