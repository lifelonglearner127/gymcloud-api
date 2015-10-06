# == Schema Information
#
# Table name: workout_templates
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  note        :text
#  video_url   :string
#  is_public   :boolean
#  author_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  folder_id   :integer
#  is_visible  :boolean          default(TRUE)
#

class WorkoutTemplate < ActiveRecord::Base

  include SearchScopes::Training

  belongs_to :author, class_name: User
  belongs_to :folder
  has_and_belongs_to_many :videos
  has_many :personal_workouts
  has_many :workout_exercises, as: :workout
  has_many :program_workouts, as: :workout

  validates :name, :author_id, presence: true
  validates :is_public, inclusion: {in: [true, false]}
  validates :name, :video_url, length: {maximum: 255}

  has_paper_trail
  acts_as_paranoid

  scope :is_visible, -> { where(is_visible: :true) }
  scope :is_invisible, -> { where(is_visible: :false) }

end
