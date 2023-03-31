# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.4.6'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem 'image_processing', "~> 1.2'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'active_model_serializers'
gem 'dotenv-rails'
gem 'elasticsearch', '~> 7.17.7'
gem 'jwt'
gem 'oj'
gem 'pagy', '~> 6.0'
gem 'panko_serializer'
gem 'pg_search', '~> 2.3.6'
gem 'pundit'
gem 'rolify'
gem 'searchkick'
gem 'stripe', '~> 8.1.0'

group :development, :test do
  gem 'benchmark'
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'capistrano', '~> 3.11'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-rvm'
  gem 'capistrano3-puma'
  gem 'database_cleaner'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker', '~> 3'
  gem 'letter_opener'
  gem 'pry', '~> 0.13.1'
  gem 'ruby_audit'
end

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'pundit-matchers', '~> 1.8.4'
  gem 'rspec-benchmark', '~> 0.6.0'
  gem 'rspec-rails', '~> 6.0.1'
  gem 'rubocop-rspec', require: false
  gem 'simplecov', require: false
end
