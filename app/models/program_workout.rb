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

  include HasTemplateVersion

  belongs_to :workout, polymorphic: true
  belongs_to :program, polymorphic: true

  validates :workout_id, :program_id, presence: true
  validates :workout_type,
            inclusion: {in: %w(WorkoutTemplate PersonalWorkout)}
  validates :program_type,
            inclusion: {in: %w(ProgramTemplate PersonalProgram)}

  has_template_version :workout

  def display_name
    source_workout.name
  end

end
