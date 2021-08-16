module API
  module Errors
    extend ActiveSupport::Concern
    included do
      rescue_from RuntimeError do |e|
        if e.message == "Vehicle not parked in garage"
          error_response(message: e.message, status: 403)
        elsif e.message == "No parking spot available"
          error_response(message: e.message, status: 406)
        else
          error_response(message: e.message, status: 500)
        end
        # elsif
        # end
      end

      rescue_from :all do |e|
        # if e.class.name == "ActiveRecord::RecordNotFound"
        if e.class.name == "ActiveRecord::RecordNotFound"
          error_response(message: e.message, status: 404)
        else
          error_response(message: e.message, status: 500)
        end
      end
    end
  end
end
