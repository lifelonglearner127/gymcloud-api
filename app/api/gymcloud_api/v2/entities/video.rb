module GymcloudAPI::V2
module Entities

class Video < Grape::Entity
  expose :id
  expose :vimeo_id
  expose :vimeo_url
  expose :embed_url
  expose :name
  expose :duration
  expose :preview_picture_url
  expose :status
  expose :privacy
  expose :uploaded_at
end

end
end
