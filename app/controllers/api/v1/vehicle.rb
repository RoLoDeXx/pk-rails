
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
          present ::Vehicle.all, with: API::V1::Entities::Vehicle, type: type
        end

        desc "create new vehicle"
        params do
          requires :number_plate, type: String
          requires :make, type: String
          requires :owner_driver_id, type: Integer
          requires :is_two_wheeler, type: Boolean
        end
        post do
          type = :vehicle
          present VehicleCrud.new(params).fetch_vehicle, with: API::V1::Entities::Vehicle, type: type
          # @res.vehicle
          # debugger
        end

        desc "edit vehicle"
        params do
          requires :number_plate, type: String
          requires :make, type: String
          requires :owner_driver_id, type: Integer
          requires :is_two_wheeler, type: Boolean
          requires :id, type: Integer
        end
        put "/:id/update" do
          ::Vehicle.find(params[:id]).update(
            number_plate: params[:number_plate],
            make: params[:make],
            owner_driver_id: params[:owner_driver_id],
            is_two_wheeler: params[:is_two_wheeler],
          )
        end

        desc "Delete vehicle"
        params do
          requires :id, type: Integer
        end
        delete "/:id/delete" do
          type = :vehicle
          present ::Vehicle.find(params[:id]).destroy!, with: API::V1::Entities::Vehicle, type: type
        end

        desc 'check in the parking spot'
        params do
          requires :vehicle_id, type: Integer
        end
        post '/:vehicle_id/checkin' do
          type = :ticket
          present Checkin.new(params[:vehicle_id]).fetch_ticket, with: API::V1::Entities::Vehicle, type: type
          #  @ticket,
        end

        desc 'check out from parking spot'
        params do
          requires :vehicle_id, type: Integer
        end
        post '/:vehicle_id/checkout' do
          type = :ticket
          present Checkout.new(params[:vehicle_id]).fetch_ticket, with: API::V1::Entities::Vehicle, type: type
          # present @ticket, with: API::V1::Entities::Vehicle, type: type
        end
      end
    end
  end
end
