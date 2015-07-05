Rails.application.routes.draw do

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  mount GymcloudAPI::API => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'

  devise_for :users

end
