# == Schema Information
#
# Table name: program_presets
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  folder_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProgramPreset < ActiveRecord::Base

  belongs_to :user
  belongs_to :folder

  validates :name, :user_id, :folder_id, presence: true
  validates :name, length: {maximum: 255}

end
