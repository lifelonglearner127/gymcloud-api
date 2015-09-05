module GymcloudAPI::V2
module Entities

class ExerciseResultItem < Grape::Entity

  expose :id
  expose :name do |item|
    item.exercise_property.personal_property.global_property.unit
  end
  expose :exercise_result_id
  expose :exercise_property_id
  expose :value

end

end
end