# == Schema Information
#
# Table name: exercises
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  video_url   :string
#  is_public   :boolean
#  author_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  folder_id   :integer
#

class Exercise < ActiveRecord::Base

  include SearchScopes::Training

  belongs_to :author, class_name: User
  belongs_to :folder
  # TODO: get rid of dependent destroy
  # After exercise delete workout_exercise should stay
  has_many :workout_exercises, dependent: :destroy

  validates :name, :author_id, presence: true
  validates :is_public, inclusion: {in: [true, false]}

  has_paper_trail

end
