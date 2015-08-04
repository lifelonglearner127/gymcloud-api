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

    %w{
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

  end

end

end
end
