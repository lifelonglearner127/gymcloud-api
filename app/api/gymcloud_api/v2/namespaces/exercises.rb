module GymcloudAPI::V2
module Namespaces

class Exercises < Base

  desc 'Create Exercise'
  post

  route_param :id do

    desc 'Read Exercise'
    get

    desc 'Update Exercise'
    patch

    desc 'Delete Exercise'
    delete

  end

end

end
end
