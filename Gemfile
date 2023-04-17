# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

gem "mysql2", "~> 0.5.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.2"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire"s SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire"s modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 5.0"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails", "~> 2.1"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.12"

gem "brakeman"
gem "bundler-audit"
gem "rubocop-rails"

gem "active_model_serializers"
gem "active_storage_validations", "1.0.3"
gem 'bootstrap', '~> 5.1.3'
gem "bootstrap-timepicker-rails"
gem "config"
gem "date_validator"
gem "devise"
gem "factory_bot"
gem "faker"
gem "figaro"
gem "flex-slider-rails"
gem "jquery-rails"
gem "jwt"
gem "mini_magick", "4.12.0"
gem "omniauth"
gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"
gem "pagy"
gem "plyr-rails"
gem "pry-rails"
gem "rack-cors"
gem "rails-i18n"
gem "ransack"
gem "sass-rails", ">= 6"
gem "sidekiq"
gem "turbolinks", "~> 5"
gem "validates_timeliness", "~> 5.0"
gem "whenever", require: false

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 3.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "database_cleaner"
  gem "rails-controller-testing"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
  gem "shoulda-callback-matchers", "~> 1.1.1"
  gem "shoulda-matchers", "~> 5.0"
  gem "simplecov"
  gem "simplecov-rcov"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails", require: false
  gem "rubocop-checkstyle_formatter", require: false
end

gem "bcrypt", "3.1.18"
gem "htmlbeautifier"
gem "net-imap", require: false
gem "net-pop", require: false
