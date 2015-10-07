module GymcloudAPI::V2
module Entities

class ProgramTemplate < Grape::Entity

  expose :id
  expose :name
  expose :description
  expose :note
  expose :is_public
  expose :author_id
  expose :author_full_name do |template|
    profile = template.author.user_profile
    [profile.first_name, profile.last_name].compact.join(' ')
  end
  expose :folder_id
  expose :program_workouts,
    using: Entities::ProgramWorkout,
    as: :workouts \
  do |model|
    model.program_workouts.without_week
  end
  expose :program_weeks,
    using: Entities::ProgramWeek,
    as: :weeks
  expose :assignees, using: Entities::ProgramAssignees do |template|
    ::PersonalProgram
      .where(program_template_id: template.id)
      .assigned_by(template.author)
  end

end

end
end
