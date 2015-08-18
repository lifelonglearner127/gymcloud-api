ActiveAdmin.register Folder do

  menu parent: 'Pro'

  permit_params :name, :user_id

  remove_filter :parent, :children, :ancestor_hierarchies,
    :self_and_ancestors, :descendant_hierarchies, :self_and_descendants

end
