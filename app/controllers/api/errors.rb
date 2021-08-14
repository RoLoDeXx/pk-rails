module API
  module Errors
    extend ActiveSupport::Concern
    included do
      rescue_from :all do |e|
        if e.class.name == "ActiveRecord::RecordNotFound"
          error_response(message: e.message, status: 404)
        else
          error_response(message: e.message, status: 500)
        end
      end
    end
  end
end
