module GymcloudAPI::V2
module Entities

class Folder < Grape::Entity

  expose :id
  expose :name
  expose :user_id

end

end
end