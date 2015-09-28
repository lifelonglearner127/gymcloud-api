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
#  avatar     :string
#

class UserProfile < ActiveRecord::Base

  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  validates :first_name, :last_name, :location, :zip,
    :employer, :avatar, length: {maximum: 255}

  enum gender: [:female, :male]

end
