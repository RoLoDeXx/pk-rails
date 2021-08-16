RSpec.shared_examples 'successful request' do
  it { expect(response.status).to eq 200 }
end

RSpec.shared_examples 'successful create request' do
  it { expect(response.status).to eq 201 }
end
