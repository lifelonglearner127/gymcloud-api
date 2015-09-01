module GymcloudAPI::V2
module Entities

class ProgramWorkout < Grape::Entity

  expose :id
  expose :display_name, as: :name
  expose :note
  expose :workout_id

end

end
end
