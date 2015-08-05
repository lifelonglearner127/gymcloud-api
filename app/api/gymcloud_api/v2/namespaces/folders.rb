module GymcloudAPI::V2
module Namespaces

class Folders < Base

  desc 'Create Folder'
  post

  route_param :id do

    desc 'Read Folder'
    get

    desc 'Update Folder'
    patch

    desc 'Delete Folder'
    delete

  end

end

end
end
