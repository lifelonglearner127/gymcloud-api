module Services
module ProgramWorkout

class Destroy < BaseService

  private

  def run
    destroy_program_workout
  end

  def input_params
    [:program_workout]
  end

  def destroy_program_workout
    try_to_destroy_workout_template
    @program_workout.destroy
  end

  def try_to_destroy_workout_template
    workout_template = @program_workout.workout
    return if workout_template.is_visible

    id = workout_template.id
    is_single_record = no_program_workouts?(id) && no_personal_workouts?(id)
    is_single_record && workout_template.destroy
  end

  def no_program_workouts?(workout_template_id)
    ::ProgramWorkout
      .where(
        workout_id: @program_workout_id,
        workout_type: 'WorkoutTemplate'
      )
      .where { id != my { workout_template_id } }
      .empty?
  end

  def no_personal_workouts?(workout_template_id)
    ::PersonalWorkout.where(workout_template_id: workout_template_id).empty?
  end

end

end
end
