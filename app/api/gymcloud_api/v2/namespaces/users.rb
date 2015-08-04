module GymcloudAPI::V2
module Namespaces

class Users < Base

  desc 'Fetch Current User'
  get :me do
  end

  route_param :id do

    desc 'Fetch User'
    get do
    end

  end

end

end
end
