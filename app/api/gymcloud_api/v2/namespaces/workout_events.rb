module GymcloudAPI::V2
module Namespaces

class WorkoutEvents < Base

  desc 'Create Workout Event'
  post

  route_param :id do

    desc 'Read Workout Event'
    get

    desc 'Update Workout Event'
    patch

    desc 'Delete Workout Event'
    delete

  end

end

end
end
