module Redbooth
  class Task < API::Task
    attr_accessor :project_id
    def self.create(data)
      {
        "project_id" => data[:project_id],
        "task_list_id" => data[:tasklist_id],
        "name" => data[:name],
        "description" => data[:description]
      }.to_json
    end
  end
end