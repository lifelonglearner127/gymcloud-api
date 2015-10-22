# == Schema Information
#
# Table name: client_groups
#
#  id         :integer          not null, primary key
#  name       :string
#  pro_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ClientGroup < ActiveRecord::Base

  include SearchScopes::ClientGroup
  belongs_to :pro, class_name: User
  has_many :client_group_memberships
  has_many :clients, class_name: User, through: :client_group_memberships

  validates :name, :pro_id, presence: true
  validates :name, length: {maximum: 255}

  scope :with_assinged_count_for, (lambda do |template|
    if template.class == WorkoutTemplate
      pws = PersonalWorkout.select { person_id }
        .where { status == my { PersonalWorkout.statuses[:active] } }
        .where { workout_template_id == my { template.id } }
    else
      pws = PersonalProgram.select { person_id }
        .where { status == my { PersonalProgram.statuses[:active] } }
        .where { program_template_id == my { template.id } }
    end
    memberships = ClientGroupMembership.select { [client_group_id, client_id] }

    joins { memberships.as(cgm).on { cgm.client_group_id == client_groups.id } }
    .joins { pws.as('pw').on { cgm.client_id == pw.person_id }.outer }
    .group { client_groups.id }
    .select do
      [
        'client_groups.*',
        count(cgm.client_id).as('clients_count'),
        count(pw.person_id).as('assigned_count')
      ]
    end
  end)

end
