module GymcloudAPI::V2
module Entities

class ProgramTemplate < Grape::Entity

  expose :id
  expose :name
  expose :description
  expose :note
  expose :is_public
  expose :author_id
  expose :folder_id
  expose :program_workouts, using: Entities::ProgramWorkout, as: :workouts

end

end
end
