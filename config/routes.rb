Rails.application.routes.draw do

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'

    mount LetterOpenerWeb::Engine, at: '/letter_opener'
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
