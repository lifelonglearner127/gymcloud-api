module GymcloudAPI
module V2

class API < Grape::API

  include APIGuard

  version 'v2', using: :header, vendor: 'gymcloud'

  helpers Helpers

  guard_all!

  default_format :json

  mount Namespaces::Root

end

end
end
