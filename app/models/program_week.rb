# == Schema Information
#
# Table name: program_weeks
#
#  id           :integer          not null, primary key
#  name         :string
#  position     :integer
#  program_id   :integer
#  program_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ProgramWeek < ActiveRecord::Base

  belongs_to :program, polymorphic: true

  has_many :program_workouts

end