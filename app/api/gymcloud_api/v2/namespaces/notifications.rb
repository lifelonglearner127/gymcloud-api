module GymcloudAPI::V2
module Namespaces

class Notifications < Base

  route_param :id do

    desc 'Mark Notification as Read'
    patch :read

  end

end

end
end
