ActiveAdmin.register Folder do

  menu parent: "Pro"

  permit_params :name, :user_id

end
