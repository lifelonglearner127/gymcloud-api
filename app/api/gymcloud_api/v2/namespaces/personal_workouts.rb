module GymcloudAPI::V2
module Namespaces

class PersonalWorkouts < Base

  desc 'Create Personal Workout'
  post

  route_param :id do

    desc 'Read Personal Workout'
    get

    desc 'Update Personal Workout'
    patch

    desc 'Delete Personal Workout'
    delete

  end

end

end
end
