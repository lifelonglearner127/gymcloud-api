ActiveAdmin.register Exercise do
  menu parent: "EWP"

  permit_params :name, :description, :video_url, :is_public, :author_id

end
