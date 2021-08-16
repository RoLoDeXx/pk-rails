require 'rails_helper'
RSpec.describe Checkin, type: :model do
  describe 'with' do
    context "Correct params" do
      before do
        @vehicle = create(:vehicle)
        @spot = create(:parking_spot)
        @ticket = Checkin.new(@vehicle.id)
      end
      it "Expect to check in a vehicle" do
        @ticket.entry(@vehicle, @spot)
      end
    end

    context "non parkable params" do
      before do
        @vehicle = create(:vehicle)
        @spot = create(:parking_spot, is_available: false)
        @ticket = Checkin.new(@vehicle.id)
      end
      it "Expect to check in a vehicle" do
        expect { @ticket.entry(@vehicle, @spot) }.to raise_error(StandardError)
      end
    end

    context "no vehicle" do
      before do
        @spot = create(:parking_spot, is_available: false)
      end
      it "Expect to check in a vehicle" do
        expect { Checkin.new(-99) }.to raise_error(StandardError)
      end
    end
  end
end
