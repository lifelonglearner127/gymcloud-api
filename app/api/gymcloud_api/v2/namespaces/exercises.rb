module GymcloudAPI::V2
module Namespaces

class Exercises < Base

  desc 'Create Exercise'
  params do
    requires :name, type: String
    optional :description, type: String
    optional :video_url, type: String
    optional :folder_id, type: Integer
    optional :is_public, type: Boolean, default: 'false'
  end
  post do
    attributes = filtered_params_with(author: current_user)
    folder_id = current_user.folders.root.children
      .where(name: 'Exercises').pluck(:id).first
    exercise = ::Exercise.new(attributes)
    exercise.folder_id = params[:folder_id] || folder_id
    authorize!(:create, exercise)
    exercise.save!
    present(exercise, with: Entities::Exercise)
  end

  desc 'Duplicate Exercise'
  params do
    requires :exercise_ids, type: Integer
    optional :folder_ids, type: Integer
  end
  post do
    old_exercises = ::Exercise.find(params[:exercise_ids])
    exercises = old_exercises.map do |old_exercise|
      authorize!(:read, old_exercise)
      params[:folder_ids].map do |folder_id|
        service = Services::TemplateDuplicating::Exercise.new(
          exercise: old_exercise,
          user: current_user,
          folder_id: folder_id
        )
        authorize!(:create, service.build)
        service.process.result
      end
    end
    exercises.flatten!(1)
    present(exercises, with: Entities::Exercise)
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
      optional :folder_id, type: Integer
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
