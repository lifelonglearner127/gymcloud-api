ActiveAdmin.register WorkoutExercise do

  menu parent: "Pro"

  permit_params :workout_template_id, :exercise_id, :note

  form do |f|
    f.inputs "#{f.object.class.to_s.underscore.humanize} Details" do
      f.input :exercise
      f.input :workout_template
      f.input :note
    end
    f.actions
  end

end
