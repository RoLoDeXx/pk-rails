FactoryBot.define do
  factory :parking_spot do
    spot_number {1}
    for_bikes_only {true}
    is_available {true}
  end
end
