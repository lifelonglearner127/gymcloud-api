module GymcloudAPI::V2
module Namespaces

class WorkoutTemplates < Base

  desc 'Create Workout Template'
  params do
    requires :name, type: String
    optional :description, type: String
    optional :note, type: String
    optional :video_url, type: String
    optional :is_public, type: Boolean, default: 'false'
  end
  post do
    attributes = filtered_params.merge(author: current_user).to_h
    present ::WorkoutTemplate.create!(attributes), with: Entities::WorkoutTemplate
  end

  params do
    requires :id, type: Integer, desc: 'WorkoutTemplate ID'
  end
  route_param :id do

    desc 'Read Workout Template'
    get do
      present ::WorkoutTemplate.find(filtered_params[:id]), with: Entities::WorkoutTemplate
    end

    desc 'Update Workout Template'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :note, type: String
      optional :video_url, type: String
      optional :is_public, type: Boolean, default: 'false'
    end
    patch do
      workout_template = ::WorkoutTemplate.find params[:id]
      workout_template.update_attributes! filtered_params.to_h
      present workout_template, with: Entities::WorkoutTemplate
    end

    desc 'Delete Workout Template'
    delete do
      present ::WorkoutTemplate.destroy(params[:id]), with: Entities::WorkoutTemplate
    end

  end

end

end
end
