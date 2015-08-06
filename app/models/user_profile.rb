# == Schema Information
#
# Table name: user_profiles
#
#  id         :integer          not null, primary key
#  gender     :integer
#  height     :decimal(, )
#  weight     :decimal(, )
#  bodyfat    :decimal(, )
#  first_name :string
#  last_name  :string
#  location   :string
#  zip        :string
#  employer   :string
#  birthday   :date
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserProfile < ActiveRecord::Base

  belongs_to :user

  enum gender: [:female, :male]

end
