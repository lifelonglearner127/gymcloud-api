module GymcloudAPI::V2
module Entities

class PersonalProgram < Grape::Entity

  expose :id
  expose :name
  expose :description
  expose :note
  expose :status
  expose :person_id
  expose :program_workouts,
    if: {nested: true},
    using: Entities::ProgramWorkout,
    as: :workouts \
  do |model|
    model.program_workouts.without_week
  end

  expose :program_weeks,
    if: {nested: true},
    using: Entities::ProgramWeek,
    as: :weeks

end

end
end
