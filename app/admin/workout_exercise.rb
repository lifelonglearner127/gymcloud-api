ActiveAdmin.register WorkoutExercise do

  menu parent: "Pro"

  permit_params :workout_id, :workout_type, :exercise_id, :note

  form do |f|
    f.inputs "#{f.object.class.to_s.underscore.humanize} Details" do
      f.input :exercise
      f.input :workout_id
      f.input :workout_type, collection: ['WorkoutTemplate', 'PersonalWorkout']
      f.input :note
    end
    f.actions
  end

end
