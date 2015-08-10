# == Schema Information
#
# Table name: personal_workouts
#
#  id                  :integer          not null, primary key
#  name                :string
#  description         :text
#  note                :text
#  workout_template_id :integer
#  person_id           :integer
#  status              :integer
#  video_url           :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class PersonalWorkout < ActiveRecord::Base

  belongs_to :workout_template
  belongs_to :person, class_name: User
  has_one :author, through: :workout_template
  has_many :workout_exercises, as: :workout
  has_many :workout_events
  has_many :program_workouts, as: :workout

  validates :name, :workout_template_id, :person_id, presence: true

  enum status: [:inactive, :active]

  scope :is_active, -> { where(status: self.statuses[:active]) }
  scope :is_inactive, -> { where(status: self.statuses[:inactive]) }

  before_create :set_workout_template_version!

  def source_workout_template
    ver = self.workout_template_version
    self.workout_template.versions.at(ver).andand.reify || self.workout_template
  end

  private

  def set_workout_template_version!
    self.workout_template_version = self.workout_template.versions.count
  end

end
