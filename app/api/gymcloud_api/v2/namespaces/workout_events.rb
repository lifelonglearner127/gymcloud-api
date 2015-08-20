module GymcloudAPI::V2
module Namespaces

class WorkoutEvents < Base

  desc 'Create Workout Event'
  params do
    requires :personal_workout_id, type: Integer
    requires :begins_at, type: DateTime
    optional :ends_at, type: DateTime
  end
  post do
    event = ::WorkoutEvent.new(filtered_params)
    authorize!(:create, event)
    event.save!

    event.personal_workout.workout_exercises.each do |exercise|
      ::WorkoutEventExercise.create!(
        workout_event: event,
        workout_exercise: exercise
      )
    end

    present(event, with: Entities::WorkoutEvent)
  end

  params do
    requires :id, type: Integer, desc: 'Workout Event ID'
  end
  route_param :id do

    desc 'Read Workout Event'
    get do
      event = ::WorkoutEvent.find(params[:id])
      authorize!(:read, event)
      present(event, with: Entities::WorkoutEvent)
    end

    desc 'Update Workout Event'
    params do
      optional :begins_at, type: DateTime
      optional :ends_at, type: DateTime
      optional :is_completed, type: Boolean
    end
    patch do
      event = ::WorkoutEvent.find(params[:id])
      event.assign_attributes(filtered_params)
      authorize!(:update, event)
      event.save!
      present(event, with: Entities::WorkoutEvent)
    end

    desc 'Delete Workout Event'
    delete do
      event = ::WorkoutEvent.find(params[:id])
      authorize!(:delete, event)
      event.destroy
      present(event, with: Entities::WorkoutEvent)
    end

    desc 'Fetch full Event content'
    get :full do
      event = ::WorkoutEvent.find(params[:id])
      authorize!(:read, event)
      present(event, with: Entities::WorkoutEventFull, expose_previous: true)
    end

  end

end

end
end
