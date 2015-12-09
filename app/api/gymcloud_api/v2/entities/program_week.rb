module GymcloudAPI::V2
module Entities

class ProgramWeek < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :name
  expose :position
  expose :program_id
  expose :program_type
  expose :program_workouts, using: Entities::ProgramWorkout

end

end
end
