ActiveAdmin.register WorkoutTemplate do
  menu parent: "EWP"

  permit_params :name, :description, :note, :video_url, :is_public, :author_id

end
