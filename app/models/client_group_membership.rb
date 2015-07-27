class ClientGroupMembership < ActiveRecord::Base
  belongs_to :client_group
  belongs_to :client, class_name: User

  validates :client_group_id, :client_id, presence: true
end
