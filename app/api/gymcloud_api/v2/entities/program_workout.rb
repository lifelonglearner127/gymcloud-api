module GymcloudAPI::V2
module Entities

class ProgramWorkout < Grape::Entity

  expose :id
  expose :name
  expose :description
  expose :note
  expose :video_url
  expose :position
  expose :workout_id
  expose :workout_type
  expose :workout_version
  expose :workout do |model|
    entity = "GymcloudAPI::V2::Entities::#{model.workout_type}".constantize
    entity.represent(model.source_workout)
  end

end

end
end
