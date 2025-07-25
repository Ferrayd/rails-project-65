# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.2.0'
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '>= 1.4'
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails'
# Hotwire"s SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'
# Hotwire"s modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails'
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'aasm'
gem 'active_storage_validations'
gem 'bootsnap', require: false
gem 'bootstrap', '~> 5.3.3'
gem 'faker'
gem 'i18n-debug'
gem 'i18n-tasks'
gem 'kaminari', '~> 1.2.2'
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection'
gem 'pundit'
gem 'rails-i18n'
gem 'ransack', '~> 4.2.0'
gem 'rollbar', '~> 3.6.0'
gem 'sassc-rails'
gem 'simple_form'
gem 'slim-rails', '~> 3.6.3'

group :development, :test do
  gem 'brakeman', require: false
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'dotenv-rails'
  gem 'minitest-power_assert'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'slim_lint'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
end

group :production do
  gem 'pg'
end

gem 'aws-sdk-s3', '~> 1.186'
