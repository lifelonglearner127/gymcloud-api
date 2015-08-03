class ProgramTemplate < ActiveRecord::Base

  belongs_to :author, class_name: User
  belongs_to :folder
  has_many :personal_programs
  has_many :program_workouts, as: :program

  validates :name, :author_id, presence: true
  validates :is_public, inclusion: { in: [true, false] }

end
