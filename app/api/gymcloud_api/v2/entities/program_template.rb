module GymcloudAPI::V2
module Entities

class ProgramTemplate < Grape::Entity

  expose :id
  expose :name
  expose :description
  expose :note
  expose :is_public
  expose :author_id
  expose :folder_id
  expose :program_workouts, using: Entities::ProgramWorkout, as: :workouts
  expose :assignees, using: Entities::ProgramAssignees do |template|
    ::PersonalProgram
      .where(program_template_id: template.id)
      .assigned_by(template.author)
  end

end

end
end
