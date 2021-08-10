require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  before(:each) do
    @vehicle = create(:vehicle)
  end

  it 'ensure @vehicle can be created' do
    expect(create(:vehicle)).to change { Vehicle.count }.by(1)
  end

  it 'checks @vehicle read' do
    expect(Vehicle.find_by(id: @vehicle.id)).to eq(@vehicle)
  end

  it 'checks update' do
    @vehicle.update(name: "Mr Samarth Sharma")
    expect(Vehicle.find_by_name("Mr Samarth Sharma")).to eq(@vehicle)
  end

  it 'checks destroy' do
    @vehicle.destroy
    expect(Vehicle.find_by(id: 1)).to be_nil
  end
end
