module GymcloudAPI::V2
module Entities

class User < Grape::Entity

  expose :id
  expose :user_profile, using: Entities::UserProfile

end

end
end
