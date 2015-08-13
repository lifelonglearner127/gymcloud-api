module Services
module PersonalAssignment

class Workout < BaseService

  input_params :template, :user, :is_program_part
  defaults is_program_part: false
  run :create_personal

  def build_personal
    PersonalWorkout.new(prepare_attributes)
  end

  private

  def create_personal
    workout = PersonalWorkout.create!(prepare_attributes)
    workout.workout_exercises.each do |item|
      workout_exercise = assign_exercise(workout, item.source_exercise)

      item.exercise_properties.each do |exercise_property|
        assign_property_to_exercise(workout_exercise, exercise_property)
      end
    end

    deactivate_old_workouts(workout.id) unless @is_program_part

    workout
  end

  def prepare_attributes
    to_exclude = %w(id is_public author_id folder_id created_at updated_at)
    @template.attributes.except(*to_exclude).merge(
      workout_template: @template,
      person: @user,
      status: :active,
      is_program_part: @is_program_part,
      workout_template_version: @template.try(:version).try(:index)
    )
  end

  def assign_exercise(workout, exercise)
    WorkoutExercise.create!(
      workout: workout,
      exercise: exercise,
      exercise_version: exercise.version.andand.index
    )
  end

  def assign_property_to_exercise(workout_exercise, exercise_property)
    ExerciseProperty.create!(
      personal_property: exercise_property.personal_property,
      workout_exercise: workout_exercise,
      value: exercise_property.value
    )
  end

  def deactivate_old_workouts(new_id)
    PersonalWorkout
      .where(
        workout_template: @template,
        person: @user
      )
      .where.not(id: new_id)
      .update_all(status: PersonalWorkout.statuses[:inactive])
  end

end

end
end
