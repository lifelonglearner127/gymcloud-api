module GymcloudAPI::V2
module Namespaces

class Comments < Base

  desc 'Create Comment'
  params do
    requires :title, type: String, default: ''
    requires :comment, type: String
    requires :commentable_id, type: Integer
    requires :commentable_type, type: String
<<<<<<< HEAD
    requires :role, type: String, default: 'comments'
=======
>>>>>>> [add] Comments api implementation
  end
  post do
    attributes = filtered_params.merge(user: current_user).to_h
    present ::Comment.create!(attributes), with: Entities::Comment
  end

  params do
    requires :id, type: Integer, desc: 'Comment ID'
  end
  route_param :id do

    desc 'Read Comment'
    get do
      present ::Comment.find(filtered_params[:id]), with: Entities::Comment
    end

    desc 'Update Comment'
    params do
      optional :title, type: String
      optional :comment, type: String
    end
    patch do
      comment = ::Comment.find params[:id]
      comment.update_attributes! filtered_params.to_h
      present comment, with: Entities::Comment
    end

    desc 'Delete Comment'
    delete do
      present ::Comment.destroy(params[:id]), with: Entities::Comment
    end

  end

end

end
end
