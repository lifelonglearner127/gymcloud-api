module GymcloudAPI::V2
module Entities

class Notification < Grape::Entity

  expose :id
  expose :trackable_id
  expose :trackable_type
  expose :owner, using: Entities::User
  expose :key
  expose :parameters
  expose :recipient_id
  expose :recipient_type
  expose :created_at

end

end
end
