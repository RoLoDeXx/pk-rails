FactoryBot.define do
  factory :vehicle do
    number_plate {"ABCDE"}
    make {"Black Tank"}
    owner_driver_id {1}
    is_two_wheeler {true}
  end
end
