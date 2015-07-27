class ClientGroup < ActiveRecord::Base
  belongs_to :pro, class_name: User
  has_many :client_group_memberships
  has_many :clients, class_name: User, through: :client_group_memberships

  validates :name, :pro_id, presence: true
end
