module GymcloudAPI::V2
module Entities

class ExerciseProperty < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :personal_property, with: Entities::PersonalProperty
  expose :workout_exercise_id
  expose :value
  expose :value2
  expose :position

end

end
end
