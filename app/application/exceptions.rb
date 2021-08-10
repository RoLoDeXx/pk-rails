class NonExistentEntity < StandardError
    def message
      ERR_MSG
    end
    private 
    ERR_MSG = 'No such entity exists'.freeze
end  