module GymcloudAPI::V2
module Namespaces

class Users < Base

  desc 'Fetch Current User'
  get :me do
  end

  route_param :id do

    desc 'Fetch User'
    get do
    end

    desc 'Invite User'
    post :invite

    namespace :collections do

      %w{
        notifications
        pros clients
        exercises workout_templates program_templates
        personal_workouts personal_programs
        personal_properties workout_events
      }.each do |collection|
        namespace collection.to_sym do
          desc "Fetch #{collection.titleize}"
          get do
          end
        end
      end

      resource :notifications do

        desc 'Mark all Notifications as Read'
        patch :read_all

      end

    end

  end

end

end
end
