module GymcloudAPI::V2
module Entities

class PersonalWorkout < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :name
  expose :description
  expose :note
  expose :video_url
  expose :status
  expose :person_id
  expose :workout_exercises,
    if: {nested: true},
    using: Entities::WorkoutExercise,
    as: :exercises
  expose :workout_template_version

end

end
end
