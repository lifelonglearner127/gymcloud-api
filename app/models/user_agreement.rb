class UserAgreement < ActiveRecord::Base
  belongs_to :pro, class_name: User
  belongs_to :client, class_name: User
  has_one :agreement_category

  enum status: [:active, :finished, :paused]

  validates :pro_id, :client_id, :category_id, :status, presence: true
end
