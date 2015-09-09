module GymcloudAPI::V2
module Entities

class WorkoutEventExercise < Grape::Entity

  expose :id
  expose :workout_event_id
  expose :workout_exercise_id
  expose :name do |workout_event_exercise|
    workout_event_exercise.workout_exercise.source_exercise.name
  end
  expose :order_name do |workout_event_exercise|
    workout_event_exercise.workout_exercise.order_name
  end
  expose :note do |workout_event_exercise|
    workout_event_exercise.workout_exercise.note
  end
  expose :exercise_results, using: Entities::ExerciseResult
  expose :exercise_properties,
    using: Entities::ExerciseProperty,
    as: :properties
  expose :comments, using: Entities::Comment
  expose :previous, using: Entities::WorkoutEventExercise, if: :expose_previous
  expose :previous, if: :expose_previous do |instance, options|
    Entities::WorkoutEventExercise.represent instance.previous,
      options.merge(expose_previous: false)
  end

end

end
end