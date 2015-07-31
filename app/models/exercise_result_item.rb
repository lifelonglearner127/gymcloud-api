class ExerciseResultItem < ActiveRecord::Base

  belongs_to :exercise_result
  belongs_to :exercise_property

  validates :exercise_result_id, :exercise_property_id, :value, presence: true
  validates :value, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
