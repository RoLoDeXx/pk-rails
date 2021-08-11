require 'rails_helper'
RSpec.describe API::Base, type: :request do
  describe 'GET /api/v1/parking/' do
    before do
      # Set the header to application/json
      # Make the actual request to /api/status using GET
      get '/api/v1/parking'
    end
    it 'Gets info about parking lot and returns HTTP status 200' do
      expect(response.status).to eq 200
    end
  end
  describe 'POST /api/v1/parking/ with correct params' do
    before do
      # Set the header to application/json
      post '/api/v1/parking', params: {"spot_number": 9, "for_bikes_only": true}
    end
    it 'Create a new driver expect code to be 201' do
      expect(response.status).to eq 201
    end
  end

  describe 'POST /api/v1/parking/ with wrong params' do
    before do
      # Set the header to application/json
      post '/api/v1/parking'
    end
    it 'Create a new driver expect code to be 201' do
      expect(response.status).to eq 400
    end
  end

  describe "check in with" do
    before(:each) do
      @vehicle = Vehicle.find_by(id: 1)
    end

    context 'correct params' do
      before do
        # Set the header to application/json
        post '/api/v1/parking/checkin', params: {"vehicle_id": @vehicle.id}
      end
      it 'to create a check in ticket' do
        expect(response.status).to eq 201
      end

      it 'to have correct json response' do
        expect JSON.parse(response.body)
      end
    end

    context 'wrong params' do
      before do
        post '/api/v1/parking/checkin'
      end
      it 'to create a check in ticket' do
        expect(response.status).to eq 400
      end
    end

    # context 'non existent vehicle' do
    #   before do
    #     post '/api/v1/parking/checkin', params: {"vehicle_id": 999}
    #     @err = StandardError.new("Vehicle can't be mapped to a parking spot")
    #   end
    #   it 'to create a check in ticket' do
    #     expect { response }.to raise_error.call(@err)
    #   end
    # end

    # context 'vehicle already parked' do
    #   before do
    #     post '/api/v1/parking/checkin', params: {"vehicle_id": @vehicle.id}
    #   end
    #   it 'to create a check in ticket' do
    #     expect { response }.to raise_error
    #   end
    # end

    # context 'checkin with non available space' do
    #   before do
    #     post '/api/v1/parking/checkin', params: {"vehicle_id": 2}
    #   end
    #   it 'Create a check in ticket' do
    #     expect(response.status).to eq 400
    #   end
    # end
  end

  describe "Checkout" do
    context 'with correct params' do
      before do
        # Set the header to application/json
        post '/api/v1/parking/checkout', params: {"spot_id": 2}
      end
      it 'check out' do
        # debugger
        expect(response.status).to eq 201
        puts response.status
      end

      it 'to have correct json response' do
        expect JSON.parse(response.body)
      end
    end

    context 'with wrong params' do
      before do
        # Set the header to application/json
        post '/api/v1/parking/checkout'
      end
      it 'check out' do
        expect(response.status).to eq 400
      end
    end

    context 'with wrong id' do
      before do
        # Set the header to application/json
        post '/api/v1/parking/checkout', params: {"spot_number": 999}
      end
      it 'check out' do
        expect { response }
      end
    end
  end
end
