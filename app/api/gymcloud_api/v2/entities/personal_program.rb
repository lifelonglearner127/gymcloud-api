module GymcloudAPI::V2
module Entities

class PersonalProgram < Grape::Entity

  expose :id
  expose :name
  expose :description
  expose :note
  expose :status
  expose :person_id
  expose :program_workouts, using: Entities::ProgramWorkout, as: :workouts

end

end
end