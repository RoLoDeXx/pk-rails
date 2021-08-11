module API
  module V1
    class Parking < Grape::API
      resource :parking do
        desc 'Get parking spot status'
        get do
          present ParkingSpot.all, with: API::V1::Entities::ParkingSpot
        end

        desc 'create a new parking spot'
        params do
          requires :spot_number, type: Integer
          requires :for_bikes_only, type: Boolean
        end
        post do
          @spot = ParkingSpot.create!(
            spot_number: params[:spot_number],
            for_bikes_only: params[:for_bikes_only],
            is_available: true,
          )
          present @spot, with: API::V1::Entities::ParkingSpot
        end
      end
    end
  end
end
