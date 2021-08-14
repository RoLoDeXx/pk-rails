module API
  class Base < Grape::API
    include API::Errors

    prefix "api"
    version "v1", using: :path
    default_format :json
    format :json
    mount API::V1::Base
  end
end
