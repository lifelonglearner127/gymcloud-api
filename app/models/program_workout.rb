# == Schema Information
#
# Table name: program_workouts
#
#  id              :integer          not null, primary key
#  workout_id      :integer
#  workout_type    :string
#  program_id      :integer
#  program_type    :string
#  workout_version :integer
#  note            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ProgramWorkout < ActiveRecord::Base

  belongs_to :workout, polymorphic: true
  belongs_to :program, polymorphic: true

  validates :workout_id, :program_id, presence: true
  validates :workout_type,
            inclusion: { in: %w(WorkoutTemplate PersonalWorkout) }
  validates :program_type,
            inclusion: { in: %w(ProgramTemplate PersonalProgram) }

  before_create :set_workout_version!, unless: :workout_version?,
                if: ->(pw) { pw.workout_type == 'WorkoutTemplate' }

  def display_name
    source_workout.name
  end

  def source_workout
    reified = workout.try(:versions).andand.at(workout_version).andand.reify
    reified || workout
  end

  private

  def set_workout_version!
    self.workout_version = workout.versions.count
  end

end
