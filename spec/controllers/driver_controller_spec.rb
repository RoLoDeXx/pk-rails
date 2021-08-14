require 'rails_helper'
RSpec.describe API::V1::Driver, type: :request do
  describe '#review' do
    # include Rack::Test::Methods

    context 'GET /api/v1/driver/' do
      before do
        @driver = create(:driver)
        get '/api/v1/driver'
      end
      it 'Get info about drivers and returns HTTP status 200' do
        expect(response.status).to eq 200
        result = JSON.parse(response.body)
        expect(result.first.keys).to(match_array(%w(id name license)))
        expect(result.first['id']).to(eq(@driver.id))
        expect(result.first['license']).to(eq(@driver.license))
        expect(result.first['name']).to(eq(@driver.name))
      end
    end

    context  'POST /api/v1/driver/' do
      before do
        post '/api/v1/driver', params: {"name": "Dem", "license": "ABCD"}
      end
      it 'Create a new driver expect code to be 201' do
        expect(response.status).to eq 201
        result = JSON.parse(response.body)
        expect(result.keys).to(match_array(%w(id name license)))
        expect(result['license']).to(eq("ABCD"))
        expect(result['name']).to(eq("Dem"))
      end
    end

    context 'create with incorrec params' do
      before do
        # Set the header to application/json
        post '/api/v1/driver', params: {"name": "Dem"}
      end
      it 'expect code to be 500' do
        expect(response.status).to eq 500
      end
    end

    context 'update driver by id' do
      before do
        # Set the header to application/json
        @driver = create(:driver)
        put '/api/v1/driver/' + @driver.id.to_s + '/update', params: {"name": "Joe", "license": "12345"}
      end
      it 'edit driver expect code to be 201' do
        expect(response.status).to eq 200
      end
    end

    context 'edit driver by id with wrong params' do
      before do
        # Set the header to application/json
        @driver = create(:driver)
        put '/api/v1/driver/' + @driver.id.to_s + '/update', params: {}
      end
      it 'edit driver expect code to be 500' do
        expect(response.status).to eq 500
      end
    end

    context 'delete driver' do
      before do
        @driver = create(:driver)
        delete '/api/v1/driver/' + @driver.id.to_s + '/delete'
      end
      it 'delete and expect code to be 200' do
        expect(response.status).to eq 200
        result = JSON.parse(response.body)
        expect(result.keys).to(match_array(%w(id name license)))
        expect(result['id']).to(eq(@driver.id))
        expect(result['license']).to(eq(@driver.license))
        expect(result['name']).to(eq(@driver.name))
      end
    end

    context 'delete non existent' do
      before do
        delete '/api/v1/driver/-1/delete'
      end
      it 'expect code to be 404' do
        expect(response.status).to eq 404
      end
    end
  end
end
