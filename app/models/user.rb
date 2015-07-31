class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :trackable, :validatable,
         :confirmable, :invitable

  acts_as_reader

  has_one :user_profile
  has_many :agreements_as_pro, class_name: UserAgreement, foreign_key: :pro_id
  has_many :agreements_as_client, class_name: UserAgreement, foreign_key: :client_id
  has_many :client_groups, foreign_key: :pro_id
  has_many :client_group_memberships
  has_many :workout_templates, foreign_key: :author_id
  has_many :personal_workouts, foreign_key: :person_id

  def display_name
    email
  end

end