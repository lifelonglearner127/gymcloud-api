module GymcloudAPI::V2
module Entities

class Exercise < Grape::Entity
  expose :id
  expose :name
  expose :description
  expose :video_url
  expose :is_public
  expose :author_id
end

end
end
