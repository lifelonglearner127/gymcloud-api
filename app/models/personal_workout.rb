class PersonalWorkout < ActiveRecord::Base

  belongs_to :workout_template
  belongs_to :person, class_name: User
  has_one :author, through: :workout_template
  has_many :workout_exercises, as: :workout

  validates :name, :workout_template_id, :person_id, presence: true

  enum status: [:inactive, :active]

  scope :is_active, -> { where(status: self.statuses[:active]) }
  scope :is_inactive, -> { where(status: self.statuses[:inactive]) }

end
