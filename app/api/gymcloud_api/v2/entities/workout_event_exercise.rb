module GymcloudAPI::V2
module Entities

class WorkoutEventExercise < Grape::Entity

  expose :id
  expose :workout_event_id
  expose :workout_exercise_id
  expose :workout_exercise, using: Entities::WorkoutExercise
  expose :comments, using: Entities::Comment

end

end
end
