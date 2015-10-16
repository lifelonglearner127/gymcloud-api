module GymcloudAPI::V2
module Entities

class ClientGroup < Grape::Entity

  expose :id
  expose :name
  expose :pro_id
  expose :clients,
    if: {nested: true},
    using: Entities::User

end

end
end
