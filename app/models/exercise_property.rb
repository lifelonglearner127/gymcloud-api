class ExerciseProperty < ActiveRecord::Base

  belongs_to :personal_property
  belongs_to :workout_exercise
  has_many :exercise_result_items

  validates :personal_property_id, :workout_exercise_id, :value, presence: true

  def display_name
    prop = self.personal_property
    "#{prop.display_name} (#{self.value} #{prop.global_property.unit})"
  end

end
