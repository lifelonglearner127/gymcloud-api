module GymcloudAPI::V2
module Entities

class ExerciseProperty < Grape::Entity

  expose :id
  expose :personal_property, with: Entities::PersonalProperty
  expose :workout_exercise_id
  expose :value
  expose :position

end

end
end
