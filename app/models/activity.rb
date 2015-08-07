class Activity < PublicActivity::Activity

  scope :of_user, ->(user) {
    client_groups = user.client_groups_as_client
    where{
      ( (recipient_type == 'User') & (recipient_id == user.id) ) |
      ( (recipient_type == 'ClientGroup') & (recipient_id >> client_groups.select{id}) )
    }
    .order(created_at: :desc)
  }

end
