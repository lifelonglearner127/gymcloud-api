module GymcloudAPI::V2
module Namespaces

class PersonalWorkouts < Base

  desc 'Create Personal Workout'
  post

  params do
    requires :id, type: Integer, desc: 'Personal Workout ID'
  end
  route_param :id do

    desc 'Read Personal Workout'
    get do
      present ::PersonalWorkout.find(params[:id]), with: Entities::PersonalWorkout
    end

    desc 'Update Personal Workout'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :note, type: String
      optional :status, type: String, desc: 'Activity status',
                values: ::PersonalWorkout.statuses.keys
      optional :video_url, type: String
    end
    patch do
      workout = ::PersonalWorkout.find params[:id]
      workout.update_attributes! filtered_params

      present workout, with: Entities::PersonalWorkout
    end

    desc 'Delete Personal Workout'
    delete do
      present ::PersonalWorkout.destroy(params[:id]), with: Entities::PersonalWorkout
    end

  end

end

end
end
