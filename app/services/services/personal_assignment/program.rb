module Services
module PersonalAssignment

class Program

  attr_reader :result

  def initialize(args = {})
    @template = args.delete(:template)
    @user = args.delete(:user)
    self
  end

  def process
    @result = create_personal
    self
  end

  private

  def create_personal
    attributes = prepare_attributes
    program = PersonalProgram.create!(attributes)

    @template.program_workouts.each do |pw|
      personal_workout = Services::PersonalAssignment::Workout
        .new(
          template: pw.source_workout,
          user: @user,
          is_program_part: true
        )
        .process
        .result

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
      status: :active,
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