module API
  module V1
    module Entities
      class ParkingSpot < Grape::Entity
        expose :id
        expose :spot_number
        expose :for_bikes_only
        expose :is_available
      end
    end
  end
end
