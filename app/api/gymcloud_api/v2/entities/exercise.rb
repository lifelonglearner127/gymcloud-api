module GymcloudAPI::V2
module Entities

class Exercise < Grape::Entity

  expose :id
  expose :name
  expose :description
  expose :video_url
  expose :folder_id
  expose :is_public
  expose :author, using: Entities::User

end

end
end
