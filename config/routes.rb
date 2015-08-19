Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  devise_for :users, controllers: {
    registrations: 'registrations',
    invitations: 'invitations',
    passwords: 'passwords'
  }

  mount GymcloudAPI::API => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'

  root to: 'devise/registrations#new'

end
