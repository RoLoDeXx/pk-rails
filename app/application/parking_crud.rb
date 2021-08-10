class ParkingCrud
    require_relative '../models/parking_spot'

    def self.retrive_all
        ParkingSpot.all
    end


    def initialize(params, availability = true)
        @spot_number = params[:spot_number]
        @for_bikes_only = params[:for_bikes_only]
        @is_available = availability
        @spot = self.insert
    end

    def insert
        ParkingSpot.create!({
            spot_number: @spot_number,
            for_bikes_only: @for_bikes_only,
            is_available: @is_available
        })
    end
end