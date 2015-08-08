module GymcloudAPI::V2
module Entities

class PersonalProperty < Grape::Entity

  expose :id
  expose :global_property_id
  expose :position
  expose :is_visible
  expose :person_id

end

end
end