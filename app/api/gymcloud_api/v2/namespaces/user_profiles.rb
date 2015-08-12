module GymcloudAPI::V2
module Namespaces

class UserProfiles < Base

  params do
    requires :id, type: Integer, desc: 'User Profile ID'
  end
  route_param :id do

    desc 'Fetch User Profile'
    get do
      profile = ::UserProfile.find(params[:id])
      authorize!(:read, profile)
      present(profile, with: Entities::UserProfile)
    end

    desc 'Update User Profile'
    params do
      optional :gender, type: String, values: ::UserProfile.genders.keys
      optional :height, type: Float
      optional :weight, type: Float
      optional :bodyfat, type: Float
      optional :first_name, type: String
      optional :last_name, type: String
      optional :location, type: String
      optional :zip, type: String
      optional :employer, type: String
      optional :birthday, type: Date
    end
    patch do
      profile = ::UserProfile.find(params[:id])
      authorize!(:update, profile)
      profile.update_attributes!(filtered_params)
      present(profile, with: Entities::UserProfile)
    end

  end

end

end
end
