module GymcloudAPI::V2
module Namespaces

class ClientGroups < Base

  desc 'Create Client Group'
  post

  route_param :id do

    desc 'Read Client Group'
    get

    desc 'Update Client Group'
    patch

    desc 'Delete Client Group'
    delete

    namespace :members do

      desc 'Fetch Members'
      get

      route_param :user_id do

        desc 'Add Member'
        post

        desc 'Remove Member'
        delete

      end

    end

  end

end

end
end
