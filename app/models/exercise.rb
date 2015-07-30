class Exercise < ActiveRecord::Base

  belongs_to :author, class_name: User
  has_many :workout_exercises, dependent: :destroy

  validates :name, :author_id, presence: true
  validates :is_public, inclusion: { in: [true, false] }

  has_paper_trail on: [:update]

end
