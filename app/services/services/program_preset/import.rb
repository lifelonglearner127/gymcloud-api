module Services
module ProgramPreset

class Import < BaseService

  def run
    import
  end

  def input_params
    %i(user program_preset)
  end

  private

  def import
    ActiveRecord::Base.transaction do
      @program_preset.program_templates.map do |program_template|
        duplicate(program_template)
      end
    end
  end

  def duplicate(program_template)
    program = Services::TemplateDuplicating::Program.!(
      program: program_template,
      user: @user,
      folder_id: @user.programs_folder.id
    )
    program.program_workouts.each do |pw|
      duplicate_workout(pw.workout)
    end
    program
  end

  def duplicate_workout(workout_template)
    workout = Services::TemplateDuplicating::Workout.!(
      workout: workout_template,
      user: @user,
      folder_id: @user.workouts_folder.id
    )
    workout.workout_exercises.each do |we|
      duplicate_exercise(we.exercise)
    end
    workout
  end

  def duplicate_exercise(exercise)
    Services::TemplateDuplicating::Exercise.!(
      exercise: exercise,
      user: @user,
      folder_id: @user.exercises_folder.id
    )
  end

end

end
end
