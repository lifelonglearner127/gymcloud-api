module GymcloudAPI::V2
module Entities

class WorkoutEvent < Grape::Entity

  expose :id
  expose :personal_workout_id
  expose :begins_at
  expose :ends_at
  expose :is_completed

end

end
end