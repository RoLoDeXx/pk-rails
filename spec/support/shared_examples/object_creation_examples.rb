RSpec.shared_examples 'successful creation' do |obj|
  it "increments the number of #{obj.name}s by 1" do
    expect { perform }.to change { obj.count }.by(1)
  end
end
