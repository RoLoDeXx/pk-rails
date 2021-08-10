module API
  module V1
    class Base < Grape::API
      class Grape::Middleware::Error
        def error_message(code, text)
          {
            error: {
              code: code,
              message: text
            }
          }.to_json
        end
      end
      mount API::V1::Driver
      mount API::V1::Parking
      mount API::V1::Vehicle
    end
  end
end
