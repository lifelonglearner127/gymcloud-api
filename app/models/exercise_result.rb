# == Schema Information
#
# Table name: exercise_results
#
#  id                  :integer          not null, primary key
#  workout_event_id    :integer
#  workout_exercise_id :integer
#  is_personal_best    :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ExerciseResult < ActiveRecord::Base

  belongs_to :workout_event
  belongs_to :workout_exercise
  has_many :exercise_result_items, dependent: :destroy
  has_one :person, through: :workout_event

  validates :workout_exercise_id, :workout_event_id, presence: true
  validate :check_exercise_workout_type

  def display_name
    "#{workout_exercise.display_name} - #{workout_event.display_name}"
  end

  private

  def check_exercise_workout_type
    return if workout_exercise.andand.workout_type == 'PersonalWorkout'
    errors.add(:workout_exercise, 'PersonalWorkout only allowed')
  end

end
