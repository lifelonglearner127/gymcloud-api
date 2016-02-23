ActiveAdmin.register User do

  menu parent: 'Users'

  permit_params :is_active, :email, :password, :password_confirmation

  actions :all, except: [:destroy]

  index do
    selectable_column
    id_column
    column :is_active
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :is_active
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "#{f.object.class.name.titleize} Details" do
      f.input :is_active
      f.input :email
      # f.input :password
      # f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def create
      parameters = permitted_params[:user].merge(confirmed_at: nil)
      @user = User.new parameters
      @user.skip_confirmation!
      super
    end
  end

end
