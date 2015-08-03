class WorkoutTemplate < ActiveRecord::Base

  belongs_to :author, class_name: User
  has_many :personal_workouts
  has_many :workout_exercises, as: :workout

  validates :name, :author_id, presence: true

  validates :is_public, inclusion: { in: [true, false] }

end
