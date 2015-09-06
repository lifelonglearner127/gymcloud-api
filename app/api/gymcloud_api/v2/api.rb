module GymcloudAPI
module V2

class API < Grape::API

  include APIGuard

  version 'v2', using: :header, vendor: 'gymcloud'

  helpers GlobalHelpers

  guard_all!

  default_format :json

  mount Namespaces::Root
  mount Namespaces::ClientGroups => 'client_groups'
  mount Namespaces::Clients => 'clients'
  mount Namespaces::Comments => 'comments'
  mount Namespaces::ExerciseProperties => 'exercise_properties'
  mount Namespaces::ExerciseResults => 'exercise_results'
  mount Namespaces::Exercises => 'exercises'
  mount Namespaces::Folders => 'folders'
  mount Namespaces::Notifications => 'notifications'
  mount Namespaces::PersonalPrograms => 'personal_programs'
  mount Namespaces::PersonalProperties => 'personal_properties'
  mount Namespaces::PersonalWorkouts => 'personal_workouts'
  mount Namespaces::ProgramTemplates => 'program_templates'
  mount Namespaces::ProgramWorkouts => 'program_workouts'
  mount Namespaces::Search => 'search'
  mount Namespaces::UserProfiles => 'user_profiles'
  mount Namespaces::Users => 'users'
  mount Namespaces::Videos => 'videos'
  mount Namespaces::WorkoutEvents => 'workout_events'
  mount Namespaces::WorkoutExercises => 'workout_exercises'
  mount Namespaces::WorkoutTemplates => 'workout_templates'

end

end
end
