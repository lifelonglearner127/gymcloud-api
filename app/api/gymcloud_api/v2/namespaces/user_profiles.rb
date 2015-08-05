module GymcloudAPI::V2
module Namespaces

class UserProfiles < Base

  route_param :id do

    desc 'Fetch User Profile'
    get

    desc 'Update User Profile'
    patch

  end

end

end
end
