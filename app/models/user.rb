class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :trackable, :validatable,
         :confirmable, :invitable

  has_one :user_profile
  has_many :agreements_as_pro, class_name: UserAgreement, foreign_key: :pro_id
  has_many :agreements_as_client, class_name: UserAgreement, foreign_key: :client_id
  has_many :client_groups, foreign_key: :pro_id
  has_many :client_group_memberships

end
