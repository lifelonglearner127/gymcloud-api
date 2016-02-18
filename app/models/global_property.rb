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
#  position   :integer
#

class GlobalProperty < ActiveRecord::Base

  has_many :personal_properties, dependent: :destroy

  validates :name, :symbol, :position, presence: true
  validates :symbol, uniqueness: true
  validates :symbol, :name, :unit, length: {maximum: 255}

  default_scope -> { order(position: :asc) }

end
