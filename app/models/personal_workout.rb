# == Schema Information
#
# Table name: personal_workouts
#
#  id                       :integer          not null, primary key
#  name                     :string
#  description              :text
#  note                     :text
#  workout_template_id      :integer
#  person_id                :integer
#  status                   :integer
#  video_url                :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  workout_template_version :integer
#  is_program_part          :boolean          default(FALSE)
#

class PersonalWorkout < ActiveRecord::Base

  include HasTemplateVersion

  belongs_to :workout_template
  belongs_to :person, class_name: User
  has_one :author, through: :workout_template
  has_many :workout_exercises, as: :workout
  has_many :workout_events
  has_many :program_workouts, as: :workout

  validates :name, :workout_template_id, :person_id, presence: true

  enum status: [:inactive, :active]

  scope :is_active, -> { where(status: statuses[:active]) }
  scope :is_inactive, -> { where(status: statuses[:inactive]) }

  has_template_version :workout_template

end
