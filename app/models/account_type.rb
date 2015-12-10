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

  has_many :user_settings, inverse_of: :account_type
  has_many :users, through: :user_settings

  validates :name, :icon, presence: true
  validates :name, :icon, length: {maximum: 255}

  before_validation :ensure_icon_has_value

  private

  def ensure_icon_has_value
    self.icon = name.to_s.parameterize.underscore if icon.blank?
  end

end
