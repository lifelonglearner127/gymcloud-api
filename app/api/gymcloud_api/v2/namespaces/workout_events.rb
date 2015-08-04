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

    desc 'Fetch full Event content'
    get :full do
      # NOTE: should include: comments, results (grouped), previous results
    end

  end

end

end
end
