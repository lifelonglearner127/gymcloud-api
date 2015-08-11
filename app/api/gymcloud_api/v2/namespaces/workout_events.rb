module GymcloudAPI::V2
module Namespaces

class WorkoutEvents < Base

  desc 'Create Workout Event'
  params do
    requires :begins_at, type: DateTime
    optional :ends_at, type: DateTime
  end
  post do
    event = ::WorkoutEvent.create!(filtered_params)
    present event, with: Entities::WorkoutEvent
  end

  params do
    requires :id, type: Integer, desc: 'Workout Event ID'
  end
  route_param :id do

    desc 'Read Workout Event'
    get do
      present ::WorkoutEvent.find(params[:id]), with: Entities::WorkoutEvent
    end

    desc 'Update Workout Event'
    params do
      optional :begins_at, type: DateTime
      optional :ends_at, type: DateTime
      optional :is_completed, type: Boolean
    end
    patch do
      event = ::WorkoutEvent.find params[:id]
      event.update_attributes! filtered_params
      present event, with: Entities::WorkoutEvent
    end

    desc 'Delete Workout Event'
    delete do
      present ::WorkoutEvent.destroy(params[:id]), with: Entities::WorkoutEvent
    end

    desc 'Fetch full Event content'
    get :full do
      # NOTE: should include: comments, results (grouped), previous results
    end

  end

end

end
end
