ActiveAdmin.register PersonalProgram do

  menu parent: 'Personal'

  permit_params :name, :description, :note, :status,
    :program_template_id, :person_id

end
