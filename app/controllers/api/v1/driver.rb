module API
  module V1
    class Driver < Grape::API
      resource :driver do
        desc 'get all drivers'
        get do
          @drivers = ::Driver.all
          present @drivers, with: API::V1::Entities::Driver
          # Ticket.all
        end

        desc 'create a new driver'
        params do
          requires :license, type: String
          requires :name, type: String
        end
        post do
          @driver = ::Driver.create!(
            license: params[:license],
            name: params[:name],
          )
          present @driver, with: API::V1::Entities::Driver
        end

        desc 'update a driver'
        params do
          requires :license, type: String
          requires :name, type: String
          requires :id, type: Integer
        end
        put "/:id/update" do
          @driver = ::Driver.find(params[:id]).update(
            license: params[:license],
            name: params[:name],
          )
        end

        desc 'delete a driver'
        params do
          requires :id, type: Integer
        end
        delete "/:id/delete" do
          @driver = ::Driver.find(params[:id]).destroy!
          present @driver, with: API::V1::Entities::Driver
        end
      end
    end
  end
end
