source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.7"

gem "rails", "~> 6.1.4"
gem "mysql2", "~> 0.5"
gem "puma", "~> 5.0"
gem "bcrypt", "~> 3.1", ">= 3.1.16"
gem "sass-rails", ">= 6"
gem "bootstrap-sass", "3.4.1"
gem "rails-bootstrap-tabs", "~> 0.2.7"
gem "webpacker", "~> 5.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "font-awesome-rails", "~> 4.7", ">= 4.7.0.7"
gem "bootsnap", ">= 1.4.4", require: false
gem "i18n", "~> 1.8", ">= 1.8.10"
gem "rails-i18n", "~> 6.0"
gem "will_paginate", "~> 3.3"
gem "bootstrap-will_paginate", "~> 1.0"
gem "faker", "~> 2.18"
gem "config", "~> 3.1"
gem "active_storage_validations", "~> 0.9.5"
gem "wicked_pdf", "~> 2.1"
gem "wkhtmltopdf-binary", "~> 0.12.6.5"
gem "roo", "~> 2.8", ">= 2.8.3"
gem "activerecord-import", "~> 1.2"
gem "groupdate", "~> 5.2", ">= 5.2.2"
gem "chartkick", "~> 4.0", ">= 4.0.5"
gem "axlsx_rails", "~> 0.6.1"
gem "sidekiq", "~>5.2.7"
gem "sidekiq-cron", "~> 1.2"
gem "bootstrap-email", "~> 0.3.4"
gem "searchkick", "~> 4.6"
gem "elasticsearch-model", "~> 7.2"
gem "elasticsearch-rails", "~> 7.2"
gem "wkhtmltopdf-heroku", "~> 2.12", ">= 2.12.6.0"
gem "figaro", "~> 1.2"
gem 'redis', '~> 4.4'
gem "devise", "~> 4.8"
gem "omniauth", "~> 2.0", ">= 2.0.4"
gem "omniauth-google-oauth2", "~> 1.0"
gem "omniauth-facebook", "~> 8.0"
gem "omniauth-rails_csrf_protection", "~> 1.0"
gem "omniauth-twitter", "~> 1.4"
group :development, :test do
  
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 4.1.0"
  gem "rack-mini-profiler", "~> 2.0"
end

group :production do
  gem "pg", "~> 1.2", ">= 1.2.3"
  gem "aws-sdk-s3", "~> 1.102"
end
  

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
