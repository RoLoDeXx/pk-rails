module API
  module V1
    module Entities
      class Vehicle < Grape::Entity
        expose :id
        expose :make, as: :make_and_color, override: true
        expose :number_plate
        expose :is_two_wheeler
        expose :owner_driver_id, as: :owner, override: true

        # t.string "number_plate"
        # t.string "make"
        # t.integer "owner_driver_id"
        # t.boolean "is_two_wheeler"
      end
    end
  end
end
