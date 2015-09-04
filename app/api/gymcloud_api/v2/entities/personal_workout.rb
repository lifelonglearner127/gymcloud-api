module GymcloudAPI::V2
module Entities

class PersonalWorkout < Grape::Entity

  expose :id
  expose :name
  expose :description
  expose :note
  expose :video_url
  expose :status
  expose :person_id
  expose :workout_exercises, using: Entities::WorkoutExercise, as: :exercises
  expose :workout_template_version

end

end
end
