module GymcloudAPI::V2
module Namespaces

class Users < Base

namespace :users do

  desc 'Fetch Current User' do
    success Entities::User
  end
  get :me do
    authorize!(:read, current_user)
    present current_user,
      with: Entities::User,
      email: true
  end

  params do
    requires :id, type: Integer, desc: 'User ID'
  end
  route_param :id do

    desc 'Fetch User' do
      success Entities::User
    end
    get do
      user = ::User.find(params[:id])
      authorize!(:read, user)
      present user,
        with: Entities::User,
        email: current_user.can?(:read_email, user)
    end

    desc 'Update User' do
      success Entities::User
    end
    params do
      optional :email, type: String, regexp: /.+@.+/
    end
    patch do
      user = ::User.find(params[:id])
      user.assign_attributes(filtered_params)
      authorize!(:update, user)
      user.save!
      present user,
        with: Entities::User,
        email: current_user.can?(:read_email, user)
    end

    desc 'Invite User' do
      success Entities::User
    end
    params do
      optional :email, type: String, regexp: /.+@.+/
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
        personal_properties
        folders
      ).each do |collection|
        namespace collection do
          desc "Fetch #{collection.to_s.titleize}"
          get do
            user = ::User.find(params[:id])
            result = user.send(collection)
            authorize!(:read, result.build)
            klass = user.association(collection).klass
            entity = "GymcloudAPI::V2::Entities::#{klass.name}".constantize
            present(result, with: entity)
          end
        end
      end

      %i(
        personal_workouts personal_programs
      ).each do |collection|
        namespace collection do
          desc "Fetch #{collection.to_s.titleize}"
          params do
            optional :status, type: String,
              values: %w(inactive active all),
              default: 'active',
              desc: 'Status of #{collection.to_s.titleize}'
          end
          get do
            scope = {
              active: :is_active,
              inactive: :is_inactive,
              all: :unscoped
            }[params[:status]] || :is_active
            user = ::User.find(params[:id])
            result = user.send(collection).send(scope)
            authorize!(:read, result.build)
            klass = user.association(collection).klass
            entity = "GymcloudAPI::V2::Entities::#{klass.name}".constantize
            present(result, with: entity)
          end
        end
      end

      resource :workout_events do
        desc 'Fetch user workout events'
        params do
          optional :scope, type: String,
            values: %w(all upcoming past all_with_clients),
            default: 'all',
            desc: 'Scope of events'
          optional :range_from, type: Date
          optional :range_to, type: Date
        end
        paginate max_per_page: 50
        get do
          user = ::User.find(params[:id])
          scope = params[:scope]
          from = params[:range_from]
          to = params[:range_to]
          workout_events = user.workout_events
          if from.present? && to.present?
            if scope == 'all'
              workout_events = workout_events.in_range(from, to)
            elsif scope == 'all_with_clients'
              workout_events = ::WorkoutEvent
                .with_clients(user)
                .in_range(from, to)
            end
          else
            workout_events = workout_events.send(scope)
          end
          workout_event = workout_events.build(
            personal_workout: ::PersonalWorkout.new(
              person: user
            )
          )
          authorize!(:read, workout_event)
          present(paginate(workout_events), with: Entities::WorkoutEvent)
        end
      end

      resource :library do
        desc 'Fetch user library'
        get do
          user = ::User.find(params[:id])
          authorize!(:update, user)
          library = user.library
          present(library)
        end
      end

      resource :notifications do

        desc 'Fetch user notifications'
        paginate max_per_page: 50
        get do
          user = ::User.find(params[:id])
          authorize!(:read, user)
          notifications = Activity.of_user(user)
          present(paginate(notifications), with: Entities::Notification)
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
end
