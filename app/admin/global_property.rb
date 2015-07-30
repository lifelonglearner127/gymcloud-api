ActiveAdmin.register GlobalProperty do

  menu parent: "Global"

  permit_params :name, :unit, :symbol

end
