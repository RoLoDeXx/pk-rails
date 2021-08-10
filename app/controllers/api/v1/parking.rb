module API
  module V1
    class Parking < Grape::API
      require_relative '../../../application/checkin'
      require_relative '../../../application/checkout'
      require_relative '../../../application/parking_crud'
      resource :parking do
        desc 'Get parking spot status'
        get do
          ParkingCrud.retrive_all
        end

        desc 'create a new parking spot'
        params do
          requires :spot_number, type: Integer
          requires :for_bikes_only, type: Boolean
        end
        post do
          @spot = ParkingCrud.new(params)
        end

        desc 'check in the parking spot'
        params do
          requires :vehicle_id, type: Integer
        end
        post '/checkin' do
          Checkin.new(params[:vehicle_id])
        end

        desc 'check out from parking spot'
        params do
          requires :spot_id, type: Integer
        end
        post '/checkout' do
          Checkout.new(params[:spot_id])
        end
      end
    end
  end
end
