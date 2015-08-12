module GymcloudAPI::V2
module Namespaces

class ClientGroups < Base

  desc 'Create Client Group'
  params do
    requires :name, type: String
  end
  post do
    attributes = filtered_params_with author: current_user
    present ::ClientGroup.create!(attributes), with: Entities::ClientGroup
  end

  params do
    requires :id, type: Integer, desc: 'ClientGroup ID'
  end
  route_param :id do

    desc 'Read Client Group'
    get do
      present ::ClientGroup.find(params[:id]), with: Entities::ClientGroup
    end

    desc 'Update Client Group'
    params do
      optional :name, type: String
    end
    patch do
      client_group = ::ClientGroup.find params[:id]
      client_group.update_attributes! filtered_params
      present client_group, with: Entities::ClientGroup
    end

    desc 'Delete Client Group'
    delete do
      present ::ClientGroup.destroy(params[:id]), with: Entities::ClientGroup
    end

    namespace :members do

      desc 'Fetch Members'
      get do
        present ::ClientGroup.find(params[:id]).clients, with: Entities::User
      end

      params do
        requires :user_id, type: Integer, desc: 'User ID'
      end
      route_param :user_id do

        desc 'Add Member'
        post do
          client_group = ::ClientGroup.find(params[:id])
          user = ::User.find(params[:user_id])
          membership = ClientGroupMembership.new(
            client_group: client_group,
            client: user
          )
          authorize!(:create, membership)
          membership.save!
          present(client_group, with: Entities::ClientGroup)
        end

        desc 'Remove Member'
        delete do
          client_group = ::ClientGroup.find(params[:id])
          user = ::User.find(params[:user_id])
          membership = client_group.client_group_memberships
            .find_by!(client_id: user.id)
          authorize!(:destroy, membership)
          membership.destroy
          present(client_group, with: Entities::ClientGroup)
        end

      end

    end

  end

end

end
end
