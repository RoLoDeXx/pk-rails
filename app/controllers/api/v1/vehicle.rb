module API
  module V1
    class Vehicle < Grape::API
      require_relative '../../../application/vehicle_crud'
      require_relative '../../../application/checkin'
      require_relative '../../../application/checkout'
      resource :vehicle do
        desc "Get vehicles"
        get do
          type = :vehicle
          present VehicleCrud.retrive_all, with: API::V1::Entities::Vehicle, type: type
        end

        desc "create new vehicle"
        params do
          requires :number_plate, type: String
          requires :make, type: String
          requires :owner_driver_id, type: Integer
          requires :is_two_wheeler, type: Boolean
        end
        post do
          # present VehicleCrud.new(params), with: API::V1::Entities::Vehicle
          VehicleCrud.new(params)
        end

        desc 'check in the parking spot'
        params do
          requires :vehicle_id, type: Integer
        end
        post '/:vehicle_id/checkin' do
          type = :ticket
          @ticket = Checkin.entry(params[:vehicle_id])
          present @ticket, with: API::V1::Entities::Vehicle, type: type
        end

        desc 'check out from parking spot'
        params do
          requires :spot_id, type: Integer
        end
        post '/:spot_id/checkout' do
          type = :ticket
          @ticket = Checkout.leave(params[:spot_id])
          present @ticket, with: API::V1::Entities::Vehicle, type: type
        end
      end
    end
  end
end
