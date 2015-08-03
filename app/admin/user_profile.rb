ActiveAdmin.register UserProfile do

  menu parent: "Users"

  permit_params :gender, :height, :weight, :bodyfat, :first_name, :last_name,
                :location, :zip, :employer, :birthday, :user_id

  form do |f|
    f.inputs "User Agreement Details" do
      f.input :user
      f.input :gender, as: :select, collection: UserProfile.genders.keys
      f.input :height
      f.input :weight
      f.input :bodyfat
      f.input :first_name
      f.input :last_name
      f.input :location
      f.input :zip
      f.input :employer
      f.input :birthday, as: :datepicker
    end
    f.actions
  end

end
