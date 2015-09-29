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
#  name            :string
#  description     :text
#  video_url       :string
#  position        :integer
#  week_id         :integer
#

class ProgramWorkout < ActiveRecord::Base

  include HasTemplateVersion

  belongs_to :workout, polymorphic: true
  belongs_to :program, polymorphic: true
  belongs_to :week, class_name: 'ProgramWeek'

  validates :workout_id, :program_id, presence: true
  validates :workout_type,
    inclusion: {in: %w(WorkoutTemplate PersonalWorkout)}
  validates :program_type,
    inclusion: {in: %w(ProgramTemplate PersonalProgram)}
  validates :name, length: {maximum: 255}

  has_template_version :workout

  scope :without_week, -> { where(week_id: nil) }

  def display_name
    source_workout.name
  end

end
