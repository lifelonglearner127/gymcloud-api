# == Schema Information
#
# Table name: workout_exercises
#
#  id               :integer          not null, primary key
#  exercise_id      :integer
#  workout_id       :integer
#  note             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  exercise_version :integer
#  workout_type     :string
#

class WorkoutExercise < ActiveRecord::Base

  include HasTemplateVersion

  belongs_to :exercise
  belongs_to :workout, polymorphic: true
  has_many :exercise_properties
  has_many :exercise_results

  validates :exercise_id, :workout_id, presence: true
  validates :workout_type,
            inclusion: {in: %w(WorkoutTemplate PersonalWorkout)}

  has_template_version :exercise

  def display_name
    source_exercise.name
  end

end
