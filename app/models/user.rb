# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#

class User < ActiveRecord::Base

  include SearchScopes::Pro
  include PublicActivity::Common

  devise \
    :database_authenticatable, :registerable,
    :recoverable, :rememberable,
    :trackable, :validatable,
    :confirmable, :invitable

  acts_as_reader

  has_one :user_profile
  has_many :agreements_as_pro, class_name: UserAgreement, foreign_key: :pro_id
  has_many :agreements_as_client,
    class_name: UserAgreement,
    foreign_key: :client_id
  has_many :pros, through: :agreements_as_client, class_name: User
  has_many :clients, through: :agreements_as_pro, class_name: User
  has_many :client_group_memberships, foreign_key: :client_id
  has_many :client_groups, foreign_key: :pro_id
  has_many :client_groups_as_client,
    through: :client_group_memberships,
    class_name: ClientGroup,
    source: :client_group
  has_many :exercises, foreign_key: :user_id
  has_many :workout_templates, foreign_key: :user_id
  has_many :personal_workouts, foreign_key: :person_id
  has_many :program_templates, foreign_key: :user_id
  has_many :personal_programs, foreign_key: :person_id
  has_many :workout_events, through: :personal_workouts
  has_many :personal_properties, foreign_key: :person_id
  has_many :exercise_results, through: :workout_events
  has_many :folders
  has_many :videos, foreign_key: :author_id

  after_invitation_accepted :on_invitation_accepted

  delegate :can?, :cannot?, to: :ability

  def ability
    @ability ||= ::Ability.new(self)
  end

  def display_name
    email
  end

  def pro?
    agreements_as_client.unscoped.is_me(id).any?
  end

  def become_a_pro!
    pro? || !!agreements_as_client.is_me(id).build.save!
  end

  def library
    return [] if folders.none?
    tree = folders.root.hash_tree
    parser = lambda do |folder, branch|
      result = folder.attributes
      result[:items] = branch.map(&parser)
      items = folder.items
      result[:items] += items.flatten if items.any?
      result
    end
    tree.map(&parser)
  end

  private

  def on_invitation_accepted
    confirm!
    create_activity(
      action: :invitation_accepted,
      owner: self,
      recipient: invited_by
    )
  end

end
