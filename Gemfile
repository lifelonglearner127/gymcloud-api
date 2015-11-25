source 'https://rubygems.org'
ruby '2.2.1'

gem 'rails', '~> 4.2.3'
gem 'pg'
gem 'jbuilder', '~> 2.0'
gem 'thin'
gem 'dotenv-rails'
gem 'seedbank'

gem 'devise'
gem 'devise_invitable'
gem 'devise-async'
gem 'omniauth'
gem 'omniauth-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'google-api-client'
gem 'yt'
gem 'cancancan'
gem 'paper_trail', '~> 4.0.0.rc'
gem 'paranoia', '~> 2.0'
gem 'acts_as_commentable'
gem 'public_activity'
gem 'unread'
gem 'ancestry'
gem 'closure_tree'

gem 'rack-cors', require: 'rack/cors'
gem 'rack-oauth2'

gem 'activeadmin', github: 'activeadmin'
gem 'active_admin_datetimepicker'

gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'grape-swagger-rails'
gem 'grape-cancan'
gem 'doorkeeper'

gem 'squeel', '~> 1.2.3'
# FIXME: ransack is frozen b/c of bad deps
# of polyamorous on squeel and activeadmin
gem 'ransack', '1.6.5'
gem 'carrierwave'
gem 'carrierwave-aws'
gem 'rmagick'

# Then choose your preferred paginator from the following:
gem 'kaminari' # will_paginate
gem 'api-pagination'

gem 'sidekiq'

gem 'vimeo', github: 'bodya-dnepr/vimeo', branch: 'v2'
gem 'andand'
gem 'faker'
gem 'ffaker'
gem 'factory_girl_rails'

group :development do
  gem 'letter_opener_web'
  gem 'sinatra', require: nil # for Sidekiq monitoring
  gem 'rails-erd'
  gem 'rubocop', require: false
  gem 'annotate', '~> 2.6.6'
  gem 'consistency_fail', require: false
  gem 'regressor', '~> 0.3.4'
  gem 'factory_factory_girl'

  gem 'guard'
  gem 'guard-bundler', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rack', require: false
  gem 'guard-rubocop', require: false
  gem 'guard-annotate', require: false
  gem 'guard-consistency_fail', require: false
  gem 'guard-regressor', github: 'patrick-nits/guard-regressor', require: false
  gem 'pry-rails'
end

group :test do
  gem 'shoulda-matchers', require: false
end

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'ruby-progressbar'

  gem 'rspec-rails', '~> 3.0'
  gem 'database_cleaner'
end

group :production do
  gem 'rails_12factor'
  gem 'puma'
  gem 'newrelic_rpm'
  gem 'newrelic-grape'
end

gem 'premailer-rails'
gem 'slim'
