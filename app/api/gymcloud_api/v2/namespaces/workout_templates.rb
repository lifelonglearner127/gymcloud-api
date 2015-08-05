module GymcloudAPI::V2
module Namespaces

class WorkoutTemplates < Base

  desc 'Create Workout Template'
  post

  route_param :id do

    desc 'Read Workout Template'
    get

    desc 'Update Workout Template'
    patch

    desc 'Delete Workout Template'
    delete

  end

end

end
end
