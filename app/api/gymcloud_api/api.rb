require 'doorkeeper/grape/helpers'

module GymcloudAPI

class API < Grape::API

  helpers Doorkeeper::Grape::Helpers

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Request-Method'] = '*'
  end

  rescue_from :all

  mount V2::API

  add_swagger_documentation \
    hide_format: true

  format :json
  default_format :json

end

end
