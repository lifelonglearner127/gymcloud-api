module GymcloudAPI::V2
module Entities

class YoutubeVideo < Grape::Entity
  expose :id
  expose :title
  expose :description
  expose :embed_url do |obj|
    "http://www.youtube.com/embed/#{obj.id}"
  end
  expose :full_url do |obj|
    "http://youtu.be/#{obj.id}"
  end
  expose :author_name do |obj|
    ""
  end
  expose :preview_picture_url do |obj|
    obj.snippet.thumbnails["medium"]["url"]
  end
  expose :published_at, as: :uploaded_at
end

end
end
