module GymcloudAPI::V2

class API < Grape::API

  include APIGuard

  version 'v2', using: :header, vendor: 'gymcloud'

  helpers GymcloudAPI::V2::Helpers

  guard_all!

end

end
