module API
  module V1
    class Vehicle < Grape::API
      require_relative '../../../application/vehicle_crud'
      resource :vehicle do
        desc "Get vehicles"
        get do
          present VehicleCrud.retrive_all
        end

        desc "create new vehicle"
        params do
          requires :number_plate, type: String
          requires :make, type: String
          requires :owner_driver_id, type: Integer
          requires :is_two_wheeler, type: Boolean
        end
        post do
          VehicleCrud.new(params)
        end
      end
    end
  end
end
