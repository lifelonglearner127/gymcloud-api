# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  trackable_id   :integer
#  trackable_type :string
#  owner_id       :integer
#  owner_type     :string
#  key            :string
#  parameters     :text
#  recipient_id   :integer
#  recipient_type :string
#  created_at     :datetime
#  updated_at     :datetime
#

class Activity < PublicActivity::Activity

  scope :of_user, (lambda do |user|
      client_groups = user.client_groups_as_client
      where {
        ((recipient_type == 'User') & (recipient_id == user.id)) |
        ((recipient_type == 'ClientGroup') & (recipient_id >> client_groups.select {id}))
      }
      .order(created_at: :desc)
    end)

end
