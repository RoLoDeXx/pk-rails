module API
  module V1
    module Entities
      class Vehicle < Grape::Entity
        expose :id
        # expose as vehicle
        with_options(if: {type: :vehicle}) do
          expose :make, as: :make_and_color, override: true
          expose :number_plate, safe: true
          expose :is_two_wheeler, safe: true
          expose :owner_driver_id, as: :driver_id, override: true, safe: true
        end
        with_options(if: {type: :ticket}) do
          # expose as ticket
          expose :spot_id, as: :parking_spot, override: true
          expose :time_entry, as: :checkin_time, override: true, safe: true
          expose :time_exit, as: :checkout_time, override: true, safe: true
          expose :fare, safe: true
          expose :driver_id, safe: true
        end
      end
    end
  end
end
