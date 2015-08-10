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
  end

end