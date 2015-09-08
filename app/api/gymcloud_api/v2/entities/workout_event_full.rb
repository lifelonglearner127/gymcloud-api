module GymcloudAPI::V2
module Entities

class WorkoutEventFull < Entities::WorkoutEvent

  expose :workout_event_exercises, as: :exercises,
          using: Entities::WorkoutEventExercise

end

end
end