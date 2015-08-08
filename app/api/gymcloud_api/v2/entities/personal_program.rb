module GymcloudAPI::V2
module Entities

class PersonalProgram < Grape::Entity

  expose :id
  expose :name
  expose :description
  expose :note
  expose :status
  expose :person_id

end

end
end