ActiveAdmin.register ClientGroupMembership do
  permit_params :client_group_id, :client_id
end
