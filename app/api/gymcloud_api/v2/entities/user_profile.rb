module GymcloudAPI::V2
module Entities

class UserProfile < Grape::Entity

  expose :id
  expose :gender
  expose :height
  expose :weight
  expose :bodyfat
  expose :first_name
  expose :last_name
  expose :location
  expose :zip
  expose :employer
  expose :birthday
  expose :user_id

end

end
end
