module GymcloudAPI::V2
module Entities

class UserProfile < Grape::Entity

  expose :id
  expose :user_id
  expose :first_name
  expose :last_name
  expose :gender
  expose :height
  expose :weight
  expose :bodyfat
  expose :location
  expose :zip
  expose :employer
  expose :birthday
  expose :avatar

end

end
end
