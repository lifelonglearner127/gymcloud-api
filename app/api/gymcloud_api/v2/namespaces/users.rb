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
      requires :email, allow_blank: false, regexp: /.+@.+/
    end
    post :invite

    namespace :collections do

      desc 'Fetch user notifications'
      get 'notifications' do
        user = ::User.find(params[:id])
        authorize!(:read, user)
        notifications = Activity.of_user(user)
        present(notifications, with: Entities::Notification)
      end

      %i(
        pros clients client_groups
        exercises workout_templates program_templates
        personal_workouts personal_programs
        personal_properties workout_events
        exercise_results
        folders
      ).each do |collection|
        namespace collection do
          desc "Fetch #{collection.to_s.titleize}"
          paginate max_per_page: 50
          get do
            user = ::User.find(params[:id])
            # TODO: authorize!
            result = user.send(collection)
            class_name = user.association(collection).klass.name
            entity_name = "Entities::#{class_name}".constantize

            present(paginate(result), with: entity_name)
          end
        end
      end

      resource :notifications do

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

      resource :folders do

        desc 'Fetch folders'
        get

      end
    end

  end

end

end
end
