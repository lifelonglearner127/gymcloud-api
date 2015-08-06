# == Schema Information
#
# Table name: workout_events
#
#  id                  :integer          not null, primary key
#  personal_workout_id :integer
#  begins_at           :datetime
#  ends_at             :datetime
#  is_completed        :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class WorkoutEvent < ActiveRecord::Base

  belongs_to :personal_workout
  has_one :person, through: :personal_workout
  has_many :exercise_results

  validates :personal_workout_id, :begins_at, presence: true
  validate :period_validation, if: :ends_at?

  def display_name
    "#{self.personal_workout.name} at #{self.begins_at}"
  end

  private

  def period_validation
    unless ends_at.between?(begins_at, begins_at + 24.hours)
      errors.add(:ends_at, 'must be within 24 hours')
    end
  end

end