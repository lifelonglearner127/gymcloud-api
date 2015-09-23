module GymcloudAPI::V2
module Entities

class ProgramWeek < Grape::Entity

  expose :id
  expose :name
  expose :position
  expose :program_id
  expose :program_type

end

end
end
