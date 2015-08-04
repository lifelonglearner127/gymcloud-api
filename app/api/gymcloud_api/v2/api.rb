module GymcloudAPI
module V2

class API < Grape::API

  include APIGuard

  version 'v2', using: :header, vendor: 'gymcloud'

  helpers GlobalHelpers

  guard_all!

  default_format :json

  mount Namespaces::Root
  mount Namespaces::Users => 'users'
  mount Namespaces::UserProfiles => 'user_profiles'
  mount Namespaces::Exercises => 'exercises'
  mount Namespaces::WorkoutTemplates => 'workout_templates'
  mount Namespaces::PersonalWorkouts => 'personal_workouts'
  mount Namespaces::ProgramTemplates => 'program_templates'
  mount Namespaces::PersonalPrograms => 'personal_programs'
  mount Namespaces::PersonalProperties => 'personal_properties'
  mount Namespaces::Notifications => 'notifications'
  mount Namespaces::Videos => 'videos'

end

end
end
