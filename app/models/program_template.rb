# == Schema Information
#
# Table name: program_templates
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  note        :text
#  is_public   :boolean
#  author_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  folder_id   :integer
#

class ProgramTemplate < ActiveRecord::Base

  include SearchScopes::Training

  belongs_to :author, class_name: User
  belongs_to :folder
  has_many :personal_programs
  has_many :program_workouts, as: :program

  validates :name, :author_id, presence: true
  validates :is_public, inclusion: { in: [true, false] }

  has_paper_trail

end