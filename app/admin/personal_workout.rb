ActiveAdmin.register PersonalWorkout do

  menu parent: 'Personal'

  permit_params :name, :description, :note, :workout_template_id, :person_id,
                :status, :video_url

end

