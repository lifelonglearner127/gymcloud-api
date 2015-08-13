module GymcloudAPI::V2
module Entities

class GlobalProperty < Grape::Entity

  expose :id
  expose :symbol
  expose :name
  expose :unit
  expose :position

end

end
end