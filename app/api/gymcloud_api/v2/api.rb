module GymcloudAPI
module V2

class API < Grape::API

  include APIGuard

  version 'v2', using: :header, vendor: 'gymcloud'

  helpers GlobalHelpers

  guard_all!

  default_format :json

  mount Namespaces::Root
  mount Namespaces::Videos => 'videos'

end

end
end
