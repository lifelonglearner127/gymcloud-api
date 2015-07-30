ActiveAdmin.register PersonalWorkout do
  menu parent: "EWP"

  permit_params :name, :description, :note, :workout_template_id, :person_id, :status, :video_url

end

