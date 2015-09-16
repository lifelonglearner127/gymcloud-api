module GymcloudAPI::V2
module Entities

class WorkoutEvent < Grape::Entity

  expose :id
  expose :personal_workout_id
  expose :begins_at
  expose :ends_at
  expose :is_completed
  expose :person_id do |event|
    event.personal_workout.person.id
  end
  expose :person_name do |event|
    profile = event.personal_workout.person.user_profile
    [profile.first_name, profile.last_name].compact.join(' ')
  end
  expose :workout_name do |event|
    event.personal_workout.name
  end
  expose :workout_note do |event|
    event.personal_workout.note
  end

end

end
end