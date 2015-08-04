module GymcloudAPI::V2
module Namespaces

class PersonalProperties < Base

  route_param :id do

    desc 'Read Personal Property'
    get

    desc 'Update Personal Property'
    patch

  end

end

end
end
