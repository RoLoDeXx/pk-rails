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

        desc 'update a spot'
        params do
          requires :spot_number, type: Integer
          requires :for_bikes_only, type: Boolean
          requires :is_available, type: Boolean
          requires :id, type: Integer
        end
        put "/:id/update" do
          @spot = ParkingSpot.find(params[:id]).update(
            spot_number: params[:spot_number],
            for_bikes_only: params[:for_bikes_only],
            is_available: params[:is_available],
          )
        end

        desc 'delete a parking spot'
        params do
          requires :id, type: Integer
        end
        delete "/:id/delete" do
          @spot = ParkingSpot.find(params[:id]).destroy!
          present @spot, with: API::V1::Entities::ParkingSpot
        end
      end
    end
  end
end
