module GymcloudAPI::V2
module Entities

class YoutubeVideo < Grape::Entity
  expose :id
  expose :title
  expose :description
  expose(:embed_url) {|obj, _| "http://www.youtube.com/embed/#{obj.id}"}
  expose(:full_url) {|obj, _| "http://youtu.be/#{obj.id}"}
  expose(:author_name) {|_,_| ""}
  expose :preview_picture_url do |obj|
    obj.snippet.thumbnails["medium"]["url"]
  end
  expose :published_at, as: :uploaded_at
end

end
end
