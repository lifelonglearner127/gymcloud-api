class WorkoutService

  def create_personal(template, user)
    to_exclude = %w(id is_public author_id folder_id created_at updated_at)
    attributes = template.attributes.except(*to_exclude).merge(
      workout_template: template,
      workout_exercise_ids: template.workout_exercise_ids,
      person: user,
      status: :active,
    )

    workout = PersonalWorkout.create! attributes
    deactivate_old_workouts(template, user, workout.id)

    workout
  end

  protected

  def deactivate_old_workouts(template, user, new_id)
    PersonalWorkout.where(
      workout_template: template,
      person: user
    )
    .where.not(id: new_id)
    .update_all(status: PersonalWorkout.statuses[:inactive])
  end

end