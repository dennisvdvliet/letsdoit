module Trello
  class Tasklist < API::Tasklist
    def initialize(data)
      super
      @project_id = data.delete("idBoard")
    end
  end
end