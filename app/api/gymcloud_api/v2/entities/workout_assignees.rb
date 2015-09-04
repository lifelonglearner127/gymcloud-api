module GymcloudAPI::V2
module Entities

class WorkoutAssignees < Grape::Entity

  expose :id
  expose :person_id
  expose :workout_template_version

end

end
end
