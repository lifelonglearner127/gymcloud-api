module Services
module PersonalAssignment

class Program < BaseService

  def run
    create_personal
  end

  def input_params
    [:template, :user]
  end

  def build_personal
    PersonalProgram.new(prepare_attributes)
  end

  private

  def create_personal
    program = PersonalProgram.create!(prepare_attributes)

    @template.program_workouts.each do |pw|
      personal_workout = create_personal_workout(pw.source_workout)

      assign_workout(program, personal_workout)
    end

    deactivate_old_programs(program.id)

    program
  end

  def assign_workout(program, workout)
    to_include = %w(name description note video_url)
    attributes = workout.attributes.slice(*to_include).merge(
      program: program,
      workout: workout
    )
    ::ProgramWorkout.create!(attributes)
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
    Services::PersonalAssignment::Workout.!(
      template: workout,
      user: @user,
      is_program_part: true
    )
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
