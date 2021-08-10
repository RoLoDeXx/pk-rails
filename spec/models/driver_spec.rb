require 'rails_helper'

RSpec.describe Driver, type: :model do
  before(:each) do
    @driver = create(:driver)
  end

  it 'ensure @driver can be created' do
    # @driver = Driver.new(license: 'ABCDE', name: 'Samarth Sharma').save
    expect { create(:driver) }.to change { Driver.count }.by(1)
  end

  it 'checks @driver read' do
    expect(Driver.find_by(id: @driver.id)).to eq(@driver)
  end

  it 'checks update' do
    @driver.update(name: "Mr Samarth Sharma")
    expect(Driver.find_by_name("Mr Samarth Sharma")).to eq(@driver)
  end

  it 'checks destroy' do
    @vehicle = create(:vehicle, owner_driver_id: @driver.id)
    @driver.destroy
    expect(Driver.find_by(id: @driver.id)).to be_nil
  end
end
