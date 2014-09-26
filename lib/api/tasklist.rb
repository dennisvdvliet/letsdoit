module API
  class Tasklist
    attr_accessor :id, :name
    def initialize(data)
      @id = data.delete("id")
      @name = data.delete("name")
    end
  end
end