module API
  class Tasklist
    attr_accessor :id, :name, :project_id
    def initialize(data)
      @id = data.delete("id")
      @name = data.delete("name")
      @project_id = data.delete("project_id")
    end
  end
end