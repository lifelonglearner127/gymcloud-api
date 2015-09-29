module GymcloudAPI::V2
module Namespaces

class Clients < Base

namespace :clients do

  desc 'Create Client'
  params do
    requires :first_name, type: String
    requires :last_name, type: String
    optional :email, type: String
  end
  post do
    service = Services::Clients::Create.new(
      attrs: filtered_params,
      current_user: current_user
    )
    client = service.build_client
    authorize!(:create, client)
    service.process
    client = service.result
    present(client, with: Entities::User)
  end

end

end

end
end
