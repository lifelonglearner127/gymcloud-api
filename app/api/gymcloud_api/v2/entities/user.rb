module GymcloudAPI::V2
module Entities

class User < Grape::Entity

  expose :id
  expose :pro?, as: :is_pro
  expose :user_profile, using: Entities::UserProfile

end

end
end
