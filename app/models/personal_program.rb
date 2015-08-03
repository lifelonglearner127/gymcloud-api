class PersonalProgram < ActiveRecord::Base

  belongs_to :program_template
  belongs_to :person, class_name: User
  has_one :author, through: :program_template
  has_many :program_workouts, as: :program

  validates :name, :program_template_id, :person_id, presence: true

  enum status: [:inactive, :active]

  scope :is_active, -> { where(status: self.statuses[:active]) }
  scope :is_inactive, -> { where(status: self.statuses[:inactive]) }

end