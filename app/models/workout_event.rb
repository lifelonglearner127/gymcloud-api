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

  include PublicActivity::Common

  acts_as_commentable

  belongs_to :personal_workout
  has_one :person, through: :personal_workout
  has_many :exercise_results, dependent: :destroy
  has_many :workout_event_exercises, dependent: :destroy

  validates :personal_workout_id, :begins_at, presence: true
  validate :period_validation, if: :ends_at?

  scope :upcoming, (lambda do
    where { begins_at > Time.current }
      .order(begins_at: :asc)
  end)
  scope :past, (lambda do
    where { begins_at < Time.current }
      .order(begins_at: :desc)
  end)
  scope :in_range, (lambda do |from, to|
    where { (begins_at >= from) & (begins_at <= to) }
      .order(begins_at: :asc)
  end)
  scope :with_clients, (lambda do |user|
    joins { personal_workout.workout_template }
      .where do
        (personal_workout.person_id >> user.clients.pluck(:id)) &
        (personal_workout.workout_template.user_id == user.id) |
        (personal_workout.person_id >> user.id)
      end
  end)

  def display_name
    "#{personal_workout.name} at #{begins_at}"
  end

  private

  def period_validation
    return if ends_at.between?(begins_at, begins_at + 24.hours)
    errors.add(:ends_at, 'must be within 24 hours')
  end

end
