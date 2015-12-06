Rails.application.routes.draw do

  match '/users/auth/google_oauth2/callback',
    to: 'oauth2#mobile_google_oauth2',
    via: [:get, :post]

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web, at: '/sidekiq'

    mount LetterOpenerWeb::Engine, at: '/letter_opener'
    get 'preview/invitation_instructions'
  end

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: {
    registrations: 'registrations',
    invitations: 'invitations',
    passwords: 'passwords'
  }

  use_doorkeeper

  mount GymcloudAPI::API => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'

  root to: 'devise/registrations#new'

end
