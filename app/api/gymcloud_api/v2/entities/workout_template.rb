module GymcloudAPI::V2
module Entities

class WorkoutTemplate < Grape::Entity

  expose :id
  expose :name
  expose :description
  expose :note
  expose :video_url
  expose :is_public
  expose :author_id
  expose :folder_id
  expose :workout_exercises, using: Entities::WorkoutExercise, as: :exercises

end

end
end
