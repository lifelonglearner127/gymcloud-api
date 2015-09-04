module GymcloudAPI::V2
module Entities

class WorkoutExercise < Grape::Entity

  expose :id
  expose :display_name, as: :name
  expose :exercise_id
  expose :workout_id
  expose :workout_type
  expose :note
  expose :description do |workout_exercise|
    workout_exercise.source_exercise.description
  end
  expose :exercise_results, using: Entities::ExerciseResult
  expose :order_name
  expose :exercise_properties, using: Entities::ExerciseProperty

end

end
end
