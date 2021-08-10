module API
  module V1
    class Driver < Grape::API
      require_relative '../../../application/driver_crud'
      resource :driver do
        desc 'get all drivers'
        get do
          DriverCrud.retrive_all
          # Ticket.all
        end

        desc 'create a new driver'
        params do
          requires :license, type: String
          requires :name, type: String
        end
        post do
          driver_obj = DriverCrud.new
          driver_obj.insert(params)
        end
      end
    end
  end
end
