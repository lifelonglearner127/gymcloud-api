module GymcloudAPI::V2
module Namespaces

class Exercises < Base

  desc 'Create Exercise'
  params do
    requires :name, type: String
    optional :description, type: String
    optional :video_url, type: String
    optional :is_public, type: Boolean, default: 'false'
  end
  post do
    attributes = filtered_params.merge(author: current_user).to_h
    present ::Exercise.create!(attributes), with: Entities::Exercise
  end

  params do
    requires :id, type: Integer, desc: 'Exercise ID'
  end
  route_param :id do

    desc 'Read Exercise'
    get do
      present ::Exercise.find(filtered_params[:id]), with: Entities::Exercise
    end

    desc 'Update Exercise'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :video_url, type: String
      optional :is_public, type: Boolean, default: 'false'
    end
    patch do
      exercise = ::Exercise.find params[:id]
      exercise.update_attributes! filtered_params.to_h
      present exercise, with: Entities::Exercise
    end

    desc 'Delete Exercise'
    delete do
      present ::Exercise.destroy(params[:id]), with: Entities::Exercise
    end

  end

end

end
end
