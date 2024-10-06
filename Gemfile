source "https://rubygems.org"

gem "bootsnap", require: false
gem "bcrypt", "~> 3.1", ">= 3.1.20"
gem "importmap-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 7.2.1"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "factory_bot_rails", "~> 6.4", ">= 6.4.3"
  gem "rspec-rails", "~> 7.0", ">= 7.0.1"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara", "~> 3.40"
  gem "selenium-webdriver", "~> 4.25"
  gem "shoulda-matchers", "~> 6.4"
end
