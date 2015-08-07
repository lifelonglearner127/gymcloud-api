module GymcloudAPI::V2
module Namespaces

class Users < Base

  desc 'Fetch Current User'
  get :me do
    present current_user, with: Entities::User
  end

  params do
    requires :id, type: Integer, desc: 'User ID'
  end
  route_param :id do

    desc 'Fetch User'
    get do
      present ::User.find(params[:id]), with: Entities::User
    end

    desc 'Invite User'
    params do
      requires :email, allow_blank: false, regexp: /.+@.+/
    end
    post :invite

    namespace :collections do

      desc 'Fetch user notifications'
      get 'notifications' do
        user = ::User.find params[:id]
        groups = user.client_groups_as_client

        result = PublicActivity::Activity.where("(
            recipient_type = 'ClientGroup'
            AND recipient_id IN (?)
          ) OR (
            recipient_type = 'User'
            AND recipient_id = ?
        )", groups.pluck(:id), user.id)
        .order(created_at: :desc)

        # notifs = PublicActivity::Activity.where(recipient: groups.to_a)
        # user_notifs = PublicActivity::Activity.where(recipient: user)
        # sql = notifs.union(user_notifs).to_sql

        # result = PublicActivity::Activity
        #           .from("#{sql} activities")
        #           .order(created_at: :desc)

        present result, with: Entities::Notification
      end

      %w{
        pros clients client_groups
        exercises workout_templates program_templates
        personal_workouts personal_programs
        personal_properties workout_events
        exercise_results
        folders
      }.each do |collection|
        namespace collection.to_sym do
          desc "Fetch #{collection.titleize}"
          get do
            user = ::User.find params[:id]
            result = user.send collection
            class_name = user.association(collection).klass.name

            present result, with: "Entities::#{class_name}".constantize
          end
        end
      end

      resource :notifications do

        desc 'Mark all Notifications as Read'
        patch :read_all

      end

    end

  end

end

end
end
