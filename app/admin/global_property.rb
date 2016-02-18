ActiveAdmin.register GlobalProperty do

  menu parent: 'Global'

  permit_params :name, :unit, :symbol, :position

  controller do

    def create
      super
      Services::GlobalProperties::Add.!(
        global_property: resource
      )
    end

  end

end
