module GymcloudAPI::V2
module Namespaces

class UserSettings < Base

namespace :user_settings do

  params do
    requires :id, type: Integer, desc: 'User Profile ID'
  end
  route_param :id do

    desc 'Fetch User Settings' do
      success Entities::UserSettings
    end
    get do
      settings = ::UserSettings.find(params[:id])
      authorize!(:read, settings)
      present(settings, with: Entities::UserSettings)
    end

    desc 'Update User Settings' do
      success Entities::UserSettings
    end
    params do
      optional :account_type_id, type: Integer
      optional :units_system, type: String,
        values: ::UserSettings.units_systems.keys
      optional :is_tutorial_finished, type: Boolean
    end
    patch do
      settings = ::UserSettings.find(params[:id])
      settings.assign_attributes(filtered_params)
      authorize!(:update, settings)
      settings.save!
      present(settings, with: Entities::UserSettings)
    end

  end

end

end

end
end
