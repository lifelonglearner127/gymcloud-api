class ProgramService

  def assign_workout(program, workout)
    ProgramWorkout.create!(program: program, workout: workout)
  end

  def create_personal(template, user)
    attributes = get_personal_attributes_from_template template, user
    program = PersonalProgram.create! attributes
    service = WorkoutService.new

    template.program_workouts.each do |pw|
      personal_workout = service.create_personal pw.source_workout, user, true
      assign_workout program, personal_workout
    end

    deactivate_old_programs(template, user, program.id)

    program
  end

  private

  def get_personal_attributes_from_template(template, user)
    to_exclude = %w(id is_public author_id folder_id created_at updated_at)
    template.attributes.except(*to_exclude).merge(
      program_template: template,
      person: user,
      status: :active,
    )
  end

  def deactivate_old_programs(template, user, new_id)
    PersonalProgram.where(
      program_template: template,
      person: user
    )
    .where.not(id: new_id)
    .update_all(status: PersonalProgram.statuses[:inactive])
  end

end