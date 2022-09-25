# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.4', '>= 6.1.4.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# gem 'webpacker', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'fast_jsonapi'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop-rails', '~> 2.15', '>= 2.15.2'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'letter_opener', '~> 1.7'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'shotgun'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'devise'
gem 'doorkeeper', '~> 5.6.0.rc2'
gem 'doorkeeper-openid_connect', '~> 1.8', '>= 1.8.2'
gem 'omniauth', '~> 1.9'
gem 'omniauth-discord'
gem 'omniauth-yandex', github: 'evrone/omniauth-yandex', branch: 'master'
gem 'pry'

gem 'dotenv-rails'
gem 'rubocop', '~> 1.32'

gem 'aws-sdk-s3', require: false

gem 'action_policy'

gem 'activestorage-database-service', github: 'TitovDigital/activestorage-database-service'

gem 'sentry-raven', '~> 3.0'

gem 'httparty', '~> 0.20.0'
gem 'net-smtp', require: false
gem 'net-imap', require: false
gem 'net-pop', require: false
