# == Schema Information
#
# Table name: global_properties
#
#  id         :integer          not null, primary key
#  symbol     :string
#  name       :string
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GlobalProperty < ActiveRecord::Base

  has_many :personal_properties

  validates :name, :unit, :symbol, presence: true
  validates :symbol, uniqueness: true

end
