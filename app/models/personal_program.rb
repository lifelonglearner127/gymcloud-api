# == Schema Information
#
# Table name: personal_programs
#
#  id                       :integer          not null, primary key
#  name                     :string
#  description              :text
#  note                     :text
#  program_template_id      :integer
#  status                   :integer
#  person_id                :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  program_template_version :integer
#

class PersonalProgram < ActiveRecord::Base

  belongs_to :program_template
  belongs_to :person, class_name: User
  has_one :author, through: :program_template
  has_many :program_workouts, as: :program

  validates :name, :program_template_id, :person_id, presence: true

  enum status: [:inactive, :active]

  scope :is_active, -> { where(status: statuses[:active]) }
  scope :is_inactive, -> { where(status: statuses[:inactive]) }

  before_create :set_program_template_version!,
                unless: :program_template_version?

  def source_program_template
    version = program_template_version
    template = program_template
    template.versions.at(version).andand.reify || template
  end

  private

  def set_program_template_version!
    self.program_template_version = program_template.versions.count
  end

end
