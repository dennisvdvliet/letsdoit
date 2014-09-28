module Trello
  class Task < API::Task
    def self.create(data)
      {
        "idList" => data[:tasklist_id],
        "name" => data[:name],
        "desc" => data[:description],
        "due" => nil,
        "pos" => "top"
      }
    end
  end
end