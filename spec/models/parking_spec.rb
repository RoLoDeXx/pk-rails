require 'rails_helper'

RSpec.describe ParkingSpot, type: :model do
  before(:each) do
    @spot = create(:parking_spot)
  end

  it 'ensure @spot can be created' do
    expect { create(:parking_spot) }.to change { ParkingSpot.count }.by(1)
  end

  it 'checks @spot can be read' do
    expect(ParkingSpot.find_by(id: @spot.id)).to eq(@spot)
  end

  it 'checks update' do
    @spot.update(is_available: false)
    expect(ParkingSpot.find_by(id: @spot.id)).to eq(@spot)
  end

  it 'checks destroy' do
    @spot.destroy
    expect(ParkingSpot.find_by(id: @spot.id)).to be_nil
  end
end
