require 'rails_helper'
RSpec.describe API::Base, type: :request do
    describe 'GET /api/v1/vehicle/' do
        before do
          # Set the header to application/json
          # Make the actual request to /api/status using GET
          get '/api/v1/vehicle'
        end
        it 'Gets info about vehicle lot and returns HTTP status 200' do
          expect(response.status).to eq 200
        end
    end
    describe 'POST /api/v1/vehicle/' do
      before do
        @driver = Driver.create(name: "Sam", license: "acd")
        # Set the header to application/json
        params = {
            number_plate: "DB69",
            make: "Benelli 501s",
            owner_driver_id: @driver.id,
            is_two_wheeler: true 
          }
        post '/api/v1/vehicle', params: params
      end
      it 'Create a new vehicle expect code to be 201' do
        expect(response.status).to eq 201
      end
  end
end
