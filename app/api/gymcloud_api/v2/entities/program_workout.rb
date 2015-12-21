module GymcloudAPI::V2
module Entities

class ProgramWorkout < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :name
  expose :description
  expose :note
  expose :video_url
  expose :position
  expose :workout_id
  expose :workout_type
  expose :workout_version
  expose :week_id
  expose :workout do |model, options|
    entity = "GymcloudAPI::V2::Entities::#{model.workout_type}".constantize
    entity.represent(model.source_workout, options)
  end

end

end
end
