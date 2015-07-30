class ExerciseProperty < ActiveRecord::Base

  belongs_to :personal_property
  belongs_to :workout_exercise

  validates :personal_property_id, :workout_exercise_id, :value, presence: true

end
