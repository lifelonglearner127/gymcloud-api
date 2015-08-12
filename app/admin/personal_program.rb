ActiveAdmin.register PersonalProgram do

  menu parent: 'Personal'

  permit_params :name, :description, :note, :program_template_id, :person_id,
                :status

end