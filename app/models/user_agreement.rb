# == Schema Information
#
# Table name: user_agreements
#
#  id          :integer          not null, primary key
#  pro_id      :integer
#  client_id   :integer
#  category_id :integer
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserAgreement < ActiveRecord::Base

  belongs_to :pro, class_name: User
  belongs_to :client, class_name: User
  belongs_to :category, class_name: AgreementCategory

  enum status: [:active, :finished, :paused]

  validates :pro_id, :client_id, :category_id, :status, presence: true

  scope :is_me, (lambda do |user_id|
    where(
      pro_id: user_id,
      client_id: user_id,
      category_id: AgreementCategory.find_by(symbol: 'me').id,
      status: statuses[:active]
    )
  end)

end
