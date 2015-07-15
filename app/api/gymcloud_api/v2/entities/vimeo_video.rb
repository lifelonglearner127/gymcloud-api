module GymcloudAPI::V2
module Entities

class VimeoVideo < Grape::Entity
  expose :id do |obj|
    obj.uri.match(/(\d+)/).captures.first.to_i
  end
  expose :name, as: :title
  expose :description
  expose :embed_url do |obj|
    str = obj.embed.html
    url = URI::extract(str).first
    url.sub("?#{URI(url).query}", '')
  end
  expose :link, as: :full_url
  expose :author_name do |obj|
    obj.user[:name]
  end
  expose :created_time, as: :uploaded_at
end

end
end
