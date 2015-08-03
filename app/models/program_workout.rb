class ProgramWorkout < ActiveRecord::Base

  belongs_to :workout, polymorphic: true
  belongs_to :program, polymorphic: true

  validates :workout_id, :program_id, presence: true
  validates :workout_type, inclusion: { in: ['WorkoutTemplate', 'PersonalWorkout'] }
  validates :program_type, inclusion: { in: ['ProgramTemplate', 'PersonalProgram'] }

  before_create :set_workout_version!

  def display_name
    self.source_workout.name
  end

  def source_workout
    self.workout.versions.at(self.workout_version - 1).andand.reify || self.workout
  end

  private

  def set_workout_version!
    self.workout_version = self.workout.versions.count
  end

end