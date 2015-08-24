module GymcloudAPI::V2
module Namespaces

class WorkoutTemplates < Base

  desc 'Create Workout Template'
  params do
    requires :name, type: String
    optional :description, type: String
    optional :note, type: String
    optional :video_url, type: String
    optional :folder_id, type: Integer
    optional :is_public, type: Boolean, default: 'false'
    optional :is_visible, type: Boolean, default: 'true'
  end
  post do
    attributes = filtered_params_with(author: current_user)
    folder_id = current_user.folders.root.children
      .where(name: 'Workouts').pluck(:id).first
    workout_template = ::WorkoutTemplate.new(attributes)
    workout_template.folder_id = params[:folder_id] || folder_id
    authorize!(:create, workout_template)
    workout_template.save!
    present(workout_template, with: Entities::WorkoutTemplate)
  end

  params do
    requires :id, type: Integer, desc: 'WorkoutTemplate ID'
  end
  route_param :id do

    desc 'Read Workout Template'
    get do
      workout_template = ::WorkoutTemplate.find(params[:id])
      authorize!(:read, workout_template)
      present(workout_template, with: Entities::WorkoutTemplate)
    end

    desc 'Update Workout Template'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :note, type: String
      optional :video_url, type: String
      optional :folder_id, type: Integer
      optional :is_public, type: Boolean
      optional :is_visible, type: Boolean
    end
    patch do
      workout_template = ::WorkoutTemplate.find(params[:id])
      workout_template.assign_attributes(filtered_params)
      authorize!(:update, workout_template)
      workout_template.save!
      present(workout_template, with: Entities::WorkoutTemplate)
    end

    desc 'Delete Workout Template'
    delete do
      workout_template = ::WorkoutTemplate.find(params[:id])
      authorize!(:destroy, workout_template)
      workout_template.destroy
      present(workout_template, with: Entities::WorkoutTemplate)
    end

  end

end

end
end
