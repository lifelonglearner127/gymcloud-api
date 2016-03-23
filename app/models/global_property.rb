# == Schema Information
#
# Table name: global_properties
#
#  id               :integer          not null, primary key
#  symbol           :string
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  position         :integer
#  property_unit_id :integer
#

class GlobalProperty < ActiveRecord::Base

  has_many :personal_properties, dependent: :destroy
  has_and_belongs_to_many :property_units

  validates :name, :symbol, :position, presence: true
  validates :symbol, uniqueness: true
  validates :symbol, :name, :unit, length: {maximum: 255}

  default_scope -> { order(position: :asc) }

end
