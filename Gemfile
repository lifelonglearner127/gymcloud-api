source 'https://rubygems.org'
ruby '2.2.1'

gem 'rails', '~> 4.2.3'
gem 'pg'
gem 'jbuilder', '~> 2.0'
gem 'thin'
gem 'dotenv-rails'

gem 'devise'
gem 'devise_invitable'
gem 'omniauth'
gem 'omniauth-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'google-api-client'
gem 'yt'
gem 'cancancan'
gem 'paper_trail', '~> 4.0.0.rc'
gem 'acts_as_commentable'
gem 'public_activity'
gem 'unread'
gem 'ancestry'

gem 'rack-cors', require: 'rack/cors'
gem 'rack-oauth2'

gem 'activeadmin', github: 'activeadmin'
gem 'active_admin_datetimepicker'

gem 'grape'
gem 'grape-entity'
gem 'grape-swagger', '~> 0.9.0'
gem 'grape-swagger-rails'
gem 'grape-cancan'
gem 'doorkeeper'

# gem 'squeel'
gem 'carrierwave'
gem 'carrierwave-aws'

# Then choose your preferred paginator from the following:
gem 'kaminari' # will_paginate
gem 'api-pagination'

gem 'sidekiq'

gem 'vimeo', github: 'bodya-dnepr/vimeo', branch: 'v2'
gem 'andand'

group :development do
  gem 'letter_opener_web'
  gem 'sinatra', require: nil # for Sidekiq monitoring
  gem 'rails-erd'

  gem 'guard'
  gem 'guard-rspec', require: false
end

group :test do
end

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'

  gem 'rspec-rails', '~> 3.0'
end

group :production do
  gem 'rails_12factor'
  gem 'puma'
  gem 'newrelic_rpm'
end
