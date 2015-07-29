ActiveAdmin.register WorkoutTemplate do

  permit_params :name, :description, :note, :video_url, :is_public, :author_id

end
