module GymcloudAPI::V2
module Entities

class ClientPerformance < Grape::Entity

  expose :id
  expose :avatar do |client|
    client.user_profile.avatar
  end
  expose :full_name do |client|
    client.user_profile.full_name
  end
  expose :last_week_performance do |client|
    events = client.workout_events.in_range(
      1.week.ago.at_beginning_of_week,
      1.week.ago.at_end_of_week
    )
    (events.is_completed.count.to_f / (events.count.to_f.nonzero? || 1)).to_f
  end
  expose :this_week_performance do |client|
    events = client.workout_events.in_range(
      Date.today.at_beginning_of_week,
      Date.today.at_end_of_week
    )
    (events.is_completed.count.to_f / (events.count.to_f.nonzero? || 1)).to_f
  end
  expose :workout_events,
    using: Entities::WorkoutEvent \
  do |client|
    client.workout_events.in_range(
      Date.today.at_beginning_of_week,
      Date.today.at_end_of_week
    )
  end

end

end
end
