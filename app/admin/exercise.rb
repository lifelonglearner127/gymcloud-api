ActiveAdmin.register Exercise do

  permit_params :name, :description, :video_url, :is_public, :author_id

end
