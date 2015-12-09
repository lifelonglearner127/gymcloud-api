# == Schema Information
#
# Table name: account_types
#
#  id         :integer          not null, primary key
#  name       :string
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AccountType < ActiveRecord::Base

  validates :name, :icon, presence: true
  validates :name, :icon, length: {maximum: 255}

end
