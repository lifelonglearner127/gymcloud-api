# == Schema Information
#
# Table name: exercise_properties
#
#  id                   :integer          not null, primary key
#  personal_property_id :integer
#  workout_exercise_id  :integer
#  value                :integer
#  position             :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class ExerciseProperty < ActiveRecord::Base

  belongs_to :personal_property
  belongs_to :workout_exercise
  has_many :exercise_result_items, dependent: :destroy

  validates :personal_property_id, :workout_exercise_id, :value, presence: true

  def display_name
    prop = personal_property
    "#{prop.display_name} (#{value} #{prop.global_property.unit})"
  end

end
