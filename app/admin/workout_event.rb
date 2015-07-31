ActiveAdmin.register WorkoutEvent do

  menu parent: "Personal"

  permit_params :personal_workout_id, :begins_at, :ends_at, :is_completed


  form do |f|
    f.inputs "#{f.object.class.to_s.underscore.humanize} Details" do
      f.input :personal_workout
      f.input :begins_at, as: :date_time_picker
      f.input :ends_at, as: :date_time_picker
      f.input :is_completed
    end
    f.actions
  end

end