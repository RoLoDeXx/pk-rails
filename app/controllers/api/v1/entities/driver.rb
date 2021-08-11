module API
  module V1
    module Entities
      class Driver < Grape::Entity
        expose :id
        expose :license
        expose :name
      end
    end
  end
end
