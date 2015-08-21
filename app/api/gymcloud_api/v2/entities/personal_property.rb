module GymcloudAPI::V2
module Entities

class PersonalProperty < Grape::Entity

  expose :id
  expose :person_id
  expose :position
  expose :is_visible
  expose :global_property, using: Entities::GlobalProperty

end

end
end