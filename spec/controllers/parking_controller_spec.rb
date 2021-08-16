require 'rails_helper'
RSpec.describe API::Base, type: :request do
  context 'GET parking spots' do
    before do
      @parking_spot = create(:parking_spot)
      get '/api/v1/parking'
    end

    include_examples 'successful request'
    it 'Gets info about parking lot and returns HTTP status 200' do
      result = JSON.parse(response.body)
      expect(result.first.keys).to(match_array(%w(id for_bikes_only is_available spot_number)))
      expect(result.first['id']).to(eq(@parking_spot.id))
      expect(result.first['for_bikes_only']).to(eq(@parking_spot.for_bikes_only))
      expect(result.first['is_available']).to(eq(@parking_spot.is_available))
      expect(result.first['spot_number']).to(eq(@parking_spot.spot_number))
    end
  end
  context 'Add a parking spot' do
    before do
      # Set the header to application/json
      @s_num = rand(1...10000)
      @random_boolean = [true, false].sample
      post '/api/v1/parking', params: {"spot_number": @s_num, "for_bikes_only": @random_boolean}
    end
    include_examples 'successful create request'

    it 'Create a new parking expect code to be 201' do
      result = JSON.parse(response.body)
      expect(result.keys).to(match_array(%w(id for_bikes_only is_available spot_number)))
      expect(result['spot_number']).to(eq(@s_num))
      expect(result['for_bikes_only']).to(eq(@random_boolean))
    end
  end

  context 'Wrong/no paramters in parking spot creation' do
    before do
      # Set the header to application/json
      post '/api/v1/parking'
    end
    it 'Create a new parking expect code to be 500' do
      expect(response.status).to eq 500
    end
  end

  context 'update parking spot' do
    before do
      # Set the header to application/json
      @parking_spot = create(:parking_spot)
      put '/api/v1/parking/' + @parking_spot.id.to_s + '/update', params: {"spot_number": 9, "for_bikes_only": true, "is_available": true}
    end
    include_examples 'successful request'
  end

  context 'update parking spot with incomplete params' do
    before do
      # Set the header to application/json
      @parking_spot = create(:parking_spot)
      put '/api/v1/parking/' + @parking_spot.id.to_s + '/update', params: {"is_available": true}
    end
    it 'updates parking spot expect code to be 500' do
      expect(response.status).to eq 500
    end
  end

  context 'delete parking spot' do
    before do
      # Set the header to application/json
      @parking_spot = create(:parking_spot)
      delete '/api/v1/parking/' + @parking_spot.id.to_s + '/delete', params: {"is_available": true}
    end
    include_examples 'successful request'
    it 'deletes parking spot expect code to be 200' do
      result = JSON.parse(response.body)
      expect(result.keys).to(match_array(%w(id for_bikes_only is_available spot_number)))
      expect(result['id']).to(eq(@parking_spot.id))
      expect(result['for_bikes_only']).to(eq(@parking_spot.for_bikes_only))
      expect(result['is_available']).to(eq(@parking_spot.is_available))
      expect(result['spot_number']).to(eq(@parking_spot.spot_number))
    end
  end

  context 'delete parking spot' do
    before do
      # Set the header to application/json
      delete '/api/v1/parking/-1/delete', params: {"is_available": true}
    end
    it 'try to delete random parking spot that doesn\'t exist' do
      expect(response.status).to eq 404
    end
  end
end
