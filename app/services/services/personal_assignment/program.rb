module Services
module PersonalAssignment

class Program < BaseService

  input_params :template, :user
  run :create_personal

  private

  def create_personal
    attributes = prepare_attributes
    program = PersonalProgram.create!(attributes)

    @template.program_workouts.each do |pw|
      personal_workout = create_personal_workout(pw.source_workout)

      assign_workout(program, personal_workout)
    end

    deactivate_old_programs(program.id)

    program
  end

  def assign_workout(program, workout)
    ProgramWorkout.create!(program: program, workout: workout)
  end

  def prepare_attributes
    to_exclude = %w(id is_public author_id folder_id created_at updated_at)
    @template.attributes.except(*to_exclude).merge(
      program_template: @template,
      person: @user,
      status: :active
    )
  end

  def create_personal_workout(workout)
    Services::PersonalAssignment::Workout
      .new(
        template: workout,
        user: @user,
        is_program_part: true
      )
      .process
      .result
  end

  def deactivate_old_programs(new_id)
    PersonalProgram
      .where(
        program_template: @template,
        person: @user
      )
      .where
      .not(id: new_id)
      .update_all(status: PersonalProgram.statuses[:inactive])
  end

end

end
end