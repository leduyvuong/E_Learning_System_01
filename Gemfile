source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.7"

gem "rails", "~> 6.1.4"
gem "mysql2", "~> 0.5"
gem "puma", "~> 5.0"
gem "bcrypt", "~> 3.1", ">= 3.1.16"
gem "sass-rails", ">= 6"
gem "bootstrap-sass", "3.4.1"
gem "jquery-rails", "~> 4.4"
gem "jquery-ui-rails", "~> 6.0", ">= 6.0.1"
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

group :development, :test do
  
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 4.1.0"
  gem "rack-mini-profiler", "~> 2.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
