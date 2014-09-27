class TaskFromTweet
  def self.call(user = nil, tweet = nil)
    task = {
      project_id: user.project_id,
      tasklist_id: user.tasklist_id,
      name: tweet.text,
      description: "Created from Twitter on #{Date.today} \nURL: #{tweet.uri}"
    }
    WebsocketRails[:tweets].trigger 'new'
    user.api.create_task(task)
  end
end