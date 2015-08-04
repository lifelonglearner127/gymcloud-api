module GymcloudAPI::V2
module Namespaces

class Comments < Base

  desc 'Create Comment'
  post

  route_param :id do

    desc 'Read Comment'
    get

    desc 'Update Comment'
    patch

    desc 'Delete Comment'
    delete

  end

end

end
end
