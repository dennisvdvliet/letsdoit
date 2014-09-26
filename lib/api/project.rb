module API
  class Project
    attr_accessor :id, :name
    # this works until we need to map from API to object in a different way
    def initialize(data)
      data.keys.each do |var|
        self.send("#{var}=", data[var]) if self.respond_to?("#{var}=")
      end
    end
  end
end