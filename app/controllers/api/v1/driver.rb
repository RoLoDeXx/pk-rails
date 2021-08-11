module API
  module V1
    class Driver < Grape::API
      resource :driver do
        desc 'get all drivers'
        get do
          @drivers = ::Driver.all
          # present @drivers, with: API::V1::Entities::Driver
          Ticket.all
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
      end
    end
  end
end
