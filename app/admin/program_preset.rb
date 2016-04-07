ActiveAdmin.register ProgramPreset do

  menu parent: 'Presets'

  permit_params :name, :user_id, :folder_id

  index do
    selectable_column
    id_column
    column :name
    column :user
    column :folder
    actions
  end

  filter :name
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "#{f.object.class.name.titleize} Details" do
      f.input :name
      f.input :user_id,
        as: :select,
        collection: ::User.gymcloud_pros
      f.input :folder_id,
        as: :select,
        collection: f.object.user ? f.object.user.programs_folder.children : []
    end
    f.actions
  end

  controller do

    before_filter :check_user, only: :new

    def check_user
      last = ::ProgramPreset.last
      @program_preset = ::ProgramPreset.new(user: last.user) unless last.nil?
    end

  end

  collection_action :user_folders, method: :get do
    user = ::User.find(params[:user_id])
    folders = user.programs_folder.children
    render json: folders
  end

end
