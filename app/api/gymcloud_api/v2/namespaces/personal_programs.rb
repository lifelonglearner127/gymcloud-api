module GymcloudAPI::V2
module Namespaces

class PersonalPrograms < Base

  desc 'Create Personal Program'
  post

  route_param :id do

    desc 'Read Personal Program'
    get

    desc 'Update Personal Program'
    patch

    desc 'Delete Personal Program'
    delete

  end

end

end
end
