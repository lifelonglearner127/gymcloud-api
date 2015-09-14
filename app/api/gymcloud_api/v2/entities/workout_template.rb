module GymcloudAPI::V2
module Entities

class WorkoutTemplate < Grape::Entity

  expose :id
  expose :name
  expose :description
  expose :note
  expose :video_url
  expose :is_public
  expose :is_visible
  expose :author_id
  expose :folder_id
  expose :version do |template|
    template.versions.count
  end
  expose :workout_exercises, using: Entities::WorkoutExercise, as: :exercises
  expose :assignees, using: Entities::WorkoutAssignees do |template|
    template.personal_workouts.assigned_by(template.author)
  end

end

end
end
