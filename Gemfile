source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

gem 'rails', '~> 7.1.2'
gem 'puma', '~> 5.6.8'
gem "bootsnap", require: false
gem 'telegram-bot'
gem 'google-apis-sheets_v4', '= 0.10.0'
gem 'google-apis-vision_v1', '= 0.1'
gem 'redis', '= 4.8'
gem 'rake'
gem 'figaro'
gem 'faraday'
gem 'sidekiq', '~> 7.2.2'
gem 'rtesseract'
gem 'whenever', require: false

group :development do
  gem 'listen'
  gem 'rubocop', require: false
  gem 'capistrano', '= 3.16.0', require: false
  gem 'capistrano-rvm',         require: false
  gem 'capistrano-rails',       require: false
  gem 'capistrano-bundler',     require: false
  gem 'capistrano3-puma',       require: false
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'faker'
end

group :test do
  gem 'vcr', '6.2.0', require: false
  gem 'webmock', '3.19.1', require: false
  gem 'timecop', '0.9.4', require: false
  gem "fakeredis", '0.9.2', require: "fakeredis/rspec"
  gem 'simplecov', require: false
end
