module GymcloudAPI::V2
module Namespaces

class Users < Base

  desc 'Fetch Current User'
  get :me do
    authorize!(:read, current_user)
    present(current_user, with: Entities::User)
  end

  params do
    requires :id, type: Integer, desc: 'User ID'
  end
  route_param :id do

    desc 'Fetch User'
    get do
      user = ::User.find(params[:id])
      authorize!(:read, user)
      present(user, with: Entities::User)
    end

    desc 'Invite User'
    params do
      optional :email, regexp: /.+@.+/
    end
    post :invite do
      user = ::User.find(params[:id])
      authorize!(:invite, user)
      Services::Clients::Invite.!(
        current_user: current_user,
        user: user,
        email: params[:email]
      )
      present(user, with: Entities::User)
    end

    namespace :collections do

      %i(
        pros clients client_groups
        exercises workout_templates program_templates
        personal_workouts personal_programs
        personal_properties workout_events
        folders
      ).each do |collection|
        namespace collection do
          desc "Fetch #{collection.to_s.titleize}"
          paginate max_per_page: 50
          get do
            user = ::User.find(params[:id])
            result = user.send(collection)
            authorize!(:read, result.build)
            klass = user.association(collection).klass
            entity = "GymcloudAPI::V2::Entities::#{klass.name}".constantize
            present(paginate(result), with: entity)
          end
        end
      end

      resource :notifications do

        desc 'Fetch user notifications'
        get do
          user = ::User.find(params[:id])
          authorize!(:read, user)
          notifications = Activity.of_user(user)
          present(notifications, with: Entities::Notification)
        end

        desc 'Mark all Notifications as Read'
        patch :read_all do
          user = ::User.find(params[:id])
          authorize!(:update, user)

          notifications = ::Activity.of_user(user).unread_by(user)

          ::Activity.transaction do
            notifications.each { |item| item.mark_as_read!(for: user) }
          end

          status :no_content
        end

      end

    end

  end

end

end
end
