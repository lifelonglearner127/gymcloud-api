module GymcloudAPI::V2
module Entities

class WorkoutExercise < Grape::Entity

  expose :id
  expose :display_name, as: :name
  expose :exercise_id
  expose :workout_id
  expose :workout_type
  expose :note
  expose :exercise_properties, using: Entities::ExerciseProperty

end

end
end
