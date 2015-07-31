class ExerciseResult < ActiveRecord::Base

  belongs_to :workout_event
  belongs_to :workout_exercise

  validates :workout_exercise_id, :workout_event_id, presence: true
  validate :check_exercise_workout_type

  private

  def check_exercise_workout_type
    unless self.workout_exercise.workout_type == 'PersonalWorkout'
      errors.add(:workout_exercise, 'PersonalWorkout only allowed')
    end
  end

end
