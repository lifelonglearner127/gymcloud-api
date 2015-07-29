class WorkoutExercise < ActiveRecord::Base

  belongs_to :exercise
  belongs_to :workout_template

  before_create :set_exercise_version!

  def source_exercise
    self.exercise.versions.at(self.exercise_version - 1).andand.reify || self.exercise
  end

  private

  def set_exercise_version!
    self.exercise_version = self.exercise.versions.count
  end

end
