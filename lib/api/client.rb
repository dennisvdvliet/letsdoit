module API
  class Client

    def initialize
    end

    def post(path, data = {})
      @conn.post(path, data).body
    end

    def get(path, data = {})
      @conn.get(path, data).body
    end

    def delete(path, data = {})
    end

  end
end