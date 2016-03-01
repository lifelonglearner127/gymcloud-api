# == Schema Information
#
# Table name: user_settings
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  user_account_type_id :integer
#  units_system         :integer
#  is_tutorial_finished :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class UserSettings < ActiveRecord::Base

  belongs_to :user
  belongs_to :user_account_type, inverse_of: :user_settings

  enum units_system: [:imperial, :metric]

end