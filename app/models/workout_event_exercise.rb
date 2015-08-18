# == Schema Information
#
# Table name: workout_event_exercises
#
#  id                  :integer          not null, primary key
#  workout_event_id    :integer
#  workout_exercise_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class WorkoutEventExercise < ActiveRecord::Base

  acts_as_commentable

  belongs_to :workout_event
  belongs_to :workout_exercise
  has_many :exercise_results, through: :workout_event

  def previous
    personal_workout_id = workout_event.personal_workout_id
    WorkoutEventExercise \
      .joins(:workout_event)
      .where('workout_events.personal_workout_id = ?', personal_workout_id)
      .where(workout_exercise_id: workout_exercise_id)
      .where { created_at < my { created_at } }
      .order(created_at: :asc)
      .last
  end

end
