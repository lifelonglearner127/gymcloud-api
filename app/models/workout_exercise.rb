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

  belongs_to :exercise
  belongs_to :workout, polymorphic: true
  has_many :exercise_properties
  has_many :exercise_results

  validates :exercise_id, :workout_id, presence: true
  validates :workout_type, inclusion: {in: %w(WorkoutTemplate PersonalWorkout)}

  before_create :set_exercise_version!,
                if: Proc.new { |we| we.exercise_version.nil? }

  def display_name
    self.source_exercise.name
  end

  def source_exercise
    ver = self.exercise_version
    self.exercise.versions.at(ver).andand.reify || self.exercise
  end

  private

  def set_exercise_version!
    self.exercise_version = self.exercise.versions.count
  end

end
