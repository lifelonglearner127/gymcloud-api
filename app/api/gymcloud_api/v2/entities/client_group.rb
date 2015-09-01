module GymcloudAPI::V2
module Entities

class ClientGroup < Grape::Entity

  expose :id
  expose :name
  expose :pro_id
  expose :clients, using: Entities::User

end

end
end
