require 'rails_helper'
RSpec.describe API::Base, type: :request do
  describe 'GET vehicles' do
    before do
      @driver = create(:driver)
      @vehicle = create(:vehicle, number_plate: "ABCDE", make: "abc", owner_driver_id: @driver.id, is_two_wheeler: true)
      get '/api/v1/vehicle'
    end
    it 'Gets info about vehicle lot and returns HTTP status 200' do
      expect(response.status).to eq 200
      result = JSON.parse(response.body)
      expect(result.first.keys).to(match_array(%w(id make_and_color number_plate is_two_wheeler driver_id)))
      expect(result.first['id']).to(eq(@vehicle.id))
      expect(result.first['make_and_color']).to(eq(@vehicle.make))
      expect(result.first['number_plate']).to(eq(@vehicle.number_plate))
      expect(result.first['driver_id']).to(eq(@driver.id))
      # expect(result.first['is_two_wheeler']).to(eq(@parking_spot.is_two_wheeler))
      # debugger
    end
  end
  describe 'create a vehicle' do
    before do
      @driver = create(:driver)
      # Set the header to application/json
      params = {
        number_plate: "DB69",
        make: "Benelli 501s",
        owner_driver_id: @driver.id,
        is_two_wheeler: true,
      }
      post '/api/v1/vehicle', params: params
    end
    it 'Create a new vehicle expect code to be 201' do
      expect(response.status).to eq 201
    end
  end

  describe "check in with" do
    context 'correct params' do
      before do
        @driver = create(:driver, name: "SAM", license: "abcde")
        @vehicle = create(:vehicle, number_plate: "abcde", make: "AVC", owner_driver_id: @driver.id, is_two_wheeler: true)
        @spot = create(:parking_spot, spot_number: 1, for_bikes_only: true, is_available: true)
        post '/api/v1/vehicle/' + @vehicle.id.to_s + '/checkin'
        @ticket = Ticket.find_by(driver_id: @driver.id)
      end
      it 'to create a check in ticket' do
        expect(response.status).to eq 201
        result = JSON.parse(response.body)
        expect(result.keys).to(match_array(%w(id parking_spot checkin_time checkout_time fare driver_id)))
        expect(result['id']).to(eq(@ticket.id))
        expect(result["parking_spot"]).to(eq(@ticket.spot_id))
        expect(result['driver_id']).to(eq(@driver.id))
      end
    end

    context 'non existent vehicle' do
      before do
        post('/api/v1/vehicle/-1/checkin')
      end
      it 'to create a check in ticket' do
        result = JSON.parse(response.body)
        # expect(result["error"]).to eq("Vehicle does not exist")
        expect(result["error"]).to eq("wrong number of arguments (given 1, expected 0)")
        expect(response.status).to eq 500
      end
    end

    context 'vehicle already parked' do
      before do
        @driver = create(:driver)
        @vehicle = create(:vehicle, number_plate: "abcde", make: "2AVC", owner_driver_id: @driver.id, is_two_wheeler: true)
        @spot = create(:parking_spot, spot_number: 2, for_bikes_only: true, is_available: true)
        post '/api/v1/vehicle/' + @vehicle.id.to_s + '/checkin'
        post '/api/v1/vehicle/' + @vehicle.id.to_s + '/checkin'
      end
      it 'to create a check in ticket' do
        result = JSON.parse(response.body)
        expect(result["error"]).to eq("No parking spot available")
        expect(response.status).to eq 406
      end
    end

    context 'checkin with non available space' do
      before do
        @vehicle = create(:vehicle, number_plate: "abcde", make: "3AVC", owner_driver_id: 1, is_two_wheeler: true)
        post '/api/v1/vehicle/' + @vehicle.id.to_s + '/checkin'
      end
      it 'Create a check in ticket' do
        result = JSON.parse(response.body)
        expect(result["error"]).to eq("No parking spot available")
        expect(response.status).to eq 406
      end
    end
  end

  describe "Checkout" do
    context 'with correct params' do
      before do
        @driver = create(:driver, name: "SAM", license: "abcde")
        @vehicle = create(:vehicle, number_plate: "abcde", make: "car", owner_driver_id: @driver.id, is_two_wheeler: true)
        @spot = create(:parking_spot, spot_number: 1, for_bikes_only: true, is_available: true)
        post '/api/v1/vehicle/' + @vehicle.id.to_s + '/checkin'
        # Set the header to application/json
        @ticket = Ticket.find_by(driver_id: @driver.id)
        post '/api/v1/vehicle/' + @vehicle.id.to_s + '/checkout'
      end
      it 'check out' do
        # debugger
        # expect(response.status).to eq 201
        # result = JSON.parse(response.body)

        # debugger
        # expect(parsed_response.keys).to eq(3)

        # # respone.body.should == model.to_json
      end

      context 'with wrong id' do
        before do
          # Set the header to application/json
          post '/api/v1/vehicle/-1/checkout'
        end
        it 'check out' do
          result = JSON.parse(response.body)
          expect(result["error"]).to eq("wrong number of arguments (given 1, expected 0)")

          # expect(result["error"]).to eq("Vehicle does not exist")
          expect(response.status).to eq 500
        end
      end
    end
  end
end
