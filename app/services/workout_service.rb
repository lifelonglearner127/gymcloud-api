class WorkoutService

  def assign_exercise(workout, exercise)
    WorkoutExercise.create!(
      workout: workout,
      exercise: exercise,
      exercise_version: exercise.version.andand.index
    )
  end

  def create_personal(template, user, is_program_part = false)
    to_exclude = %w(id is_public author_id folder_id created_at updated_at)
    attributes = template.attributes.except(*to_exclude).merge(
      workout_template: template,
      person: user,
      status: :active,
      is_program_part: is_program_part,
      workout_template_version: template.version.andand.index,
    )

    workout = PersonalWorkout.create! attributes
    workout.workout_exercises.each do |item|
      workout_exercise = assign_exercise(workout, item.source_exercise)

      item.exercise_properties.each do |exercise_property|
        assign_property_to_exercise(workout_exercise, exercise_property)
      end
    end

    deactivate_old_workouts(template, user, workout.id) unless is_program_part

    workout
  end

  protected

  def assign_property_to_exercise(workout_exercise, exercise_property)
    ExerciseProperty.create!(
      personal_property: exercise_property.personal_property,
      workout_exercise: workout_exercise,
      value: exercise_property.value
    )
  end

  def deactivate_old_workouts(template, user, new_id)
    PersonalWorkout.where(
      workout_template: template,
      person: user
    )
    .where.not(id: new_id)
    .update_all(status: PersonalWorkout.statuses[:inactive])
  end

end