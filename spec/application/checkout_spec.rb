require 'rails_helper'
RSpec.describe Checkout, type: :model do
  describe 'with' do
    context "correct params" do
      before do
        @vehicle = create(:vehicle)
        @spot = create(:parking_spot)
        @ticket = Checkin.new(@vehicle.id)
      end
      it "from parked vehicle" do
        # Checkout.new(@vehicle.id)
      end
    end

    context "no vehicle checked in" do
      it "Expect to check in a vehicle" do
        expect { Checkout.new(-99) }.to raise_error(StandardError)
      end
    end
  end
end
