module GymcloudAPI::V2

class API < Grape::API

  version 'v2', using: :header, vendor: 'gymcloud'

  helpers Helpers

end

end
