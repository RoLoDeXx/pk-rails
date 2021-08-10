module API
  module V1
    module Entities
      class Vehicle < Grape::Entity
        expose :id
        expose :make
      end
    end
  end
end
