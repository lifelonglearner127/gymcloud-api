module GymcloudAPI::V2
module Namespaces

class ClientGroups < Base

  desc 'Create Client Group'
  params do
    requires :name, type: String
  end
  post do
    attributes = filtered_params.merge(pro: current_user).to_h
    present ::ClientGroup.create!(attributes), with: Entities::ClientGroup
  end

  params do
    requires :id, type: Integer, desc: 'ClientGroup ID'
  end
  route_param :id do

    desc 'Read Client Group'
    get do
      present ::ClientGroup.find(filtered_params[:id]), with: Entities::ClientGroup
    end

    desc 'Update Client Group'
    params do
      optional :name, type: String
    end
    patch do
      client_group = ::ClientGroup.find params[:id]
      client_group.update_attributes! filtered_params.to_h
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
          group = ::ClientGroup.find(params[:id])
          user = ::User.find(params[:user_id])
          group.clients << user unless group.clients.include?(user)
          present user, with: Entities::User
        end

        desc 'Remove Member'
        delete do
          group = ::ClientGroup.find(params[:id])
          user = ::User.find(params[:user_id])
          group.clients = group.clients - [user]
          present user, with: Entities::User
        end

      end

    end

  end

end

end
end
