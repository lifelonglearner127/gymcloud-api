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
    attributes = filtered_params_with(author: current_user)
    exercise = ::Exercise.new(attributes)
    authorize!(:create, exercise)
    exercise.save!
    present(exercise, with: Entities::Exercise)
  end

  params do
    requires :id, type: Integer, desc: 'Exercise ID'
  end
  route_param :id do

    desc 'Read Exercise'
    get do
      exercise = ::Exercise.find(params[:id])
      authorize!(:read, exercise)
      present(exercise, with: Entities::Exercise)
    end

    desc 'Update Exercise'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :video_url, type: String
      optional :is_public, type: Boolean
    end
    patch do
      exercise = ::Exercise.find(params[:id])
      exercise.assign_attributes(filtered_params)
      authorize!(:update, exercise)
      exercise.save!
      present(exercise, with: Entities::Exercise)
    end

    desc 'Delete Exercise'
    delete do
      exercise = ::Exercise.find(params[:id])
      authorize!(:destroy, exercise)
      exercise.destroy
      present(exercise, with: Entities::Exercise)
    end

  end

end

end
end
