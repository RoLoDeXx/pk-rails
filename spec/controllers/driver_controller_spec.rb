require 'rails_helper'
RSpec.describe API::V1::Driver, type: :request do
  describe '#review' do
    # include Rack::Test::Methods

    describe 'GET /api/v1/driver/' do
      before do
        # Set the header to application/json
        # Make the actual request to /api/status using GET
        get '/api/v1/driver'
      end
      it 'Get info about drivers and returns HTTP status 200' do
        expect(response.status).to eq 200
      end
    end

    describe 'POST /api/v1/driver/' do
      before do
        # Set the header to application/json
        post '/api/v1/driver', params: { "name": "Dem", "license": "ABCD" }
      end
      it 'Create a new driver expect code to be 201' do
        expect(response.status).to eq 201
      end
    end
  end
end
