module GymcloudAPI::V2
module Namespaces

class PersonalWorkouts < Base

  desc 'Create Personal Workout'
  params do
    requires :workout_template_id, type: Integer, desc: 'Workout Template ID'
    requires :person_id, type: Integer, desc: 'Assigned Person ID'
  end
  post do
    template = ::WorkoutTemplate.find(params[:workout_template_id])
    user = ::User.find(params[:person_id])
    service = Services::PersonalAssignment::Workout.new(
      template: template,
      user: user
    )
    authorize!(:create, service.build_personal)
    workout = service.process.result
    present(workout, with: Entities::PersonalWorkout)
  end

  params do
    requires :id, type: Integer, desc: 'Personal Workout ID'
  end
  route_param :id do

    desc 'Read Personal Workout'
    get do
      workout = ::PersonalWorkout.find(params[:id])
      authorize!(:read, workout)
      present(workout, with: Entities::PersonalWorkout)
    end

    desc 'Update Personal Workout'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :note, type: String
      optional :video_url, type: String
    end
    patch do
      workout = ::PersonalWorkout.is_active.find(params[:id])
      workout.assign_attributes(filtered_params)
      authorize!(:update, workout)
      workout.save!
      present(workout, with: Entities::PersonalWorkout)
    end

    desc 'Disable Personal Workout'
    delete do
      workout = ::PersonalWorkout.is_active.find(params[:id])
      authorize!(:disable, workout)
      workout.update_attributes!(status: :inactive)
      present(workout, with: Entities::PersonalWorkout)
    end

  end

end

end
end
