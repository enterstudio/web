source 'https://rubygems.org'

gem 'rails', '7.1.0'
gem 'sass-rails', '~> 6.0', '>= 6.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2.2'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails', '>= 4.2.0'
gem 'jbuilder', '~> 2.6', '>= 2.6.4'
gem 'sdoc', '~> 1.0.0', group: :doc
gem 'puma'

gem 'devise', '>= 4.7.0'
gem 'devise_invitable', '>= 1.6.1'
gem 'simple_form', '>= 4.0.0'
gem 'haml-rails', '>= 2.1.0'
gem 'bootstrap-sass'
gem 'font-awesome-rails', '>= 4.7.0.8'
gem 'money', '>= 6.8.2'
gem 'chronic'
gem 'activeadmin', '~> 2.0.0.0'
gem 'cancancan', '~> 1.10'
gem 'ruby-progressbar'
gem 'parallel'

gem 'omniauth-facebook', '>= 4.0.0'
gem 'omniauth-twitter', '>= 1.3.0'
gem 'twitter'
gem 'koala', '~> 2.5', '>= 2.5.0'
gem 'stripe'
gem 'louvian_ruby'
gem 'terminal-table'
gem 'sidekiq'
gem 'icalendar'
gem 'kramdown'
gem 'best_in_place', '~> 3.1.0'
gem 'dotenv-rails', '>= 2.7.6'
gem 'google_calendar', '>= 0.6.0'
gem 'mini_magick'
gem 'carrierwave', '~> 1.1', '>= 1.1.0'

group :development do
  gem 'web-console', '~> 3.0', '>= 3.0.0'
  gem 'better_errors', '>= 2.2.0'
  gem 'quiet_assets'
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
  gem 'rack-mini-profiler', '>= 0.10.2'
  gem 'letter_opener', '>= 1.5.0'
end

group :development, :test do
  gem 'rspec-rails', '>= 3.5.2'
  gem 'pry'
  gem 'fabrication'
  gem 'faker'
  gem 'rubocop', require: false
  gem 'fuubar', require: false
end

group :test do
  gem 'rr', '1.1.2', require: false
  gem 'stripe-ruby-mock', '~> 2.1.1', :require => 'stripe_mock'
  gem 'timecop'
  gem 'simplecov', require: false
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'lograge', '>= 0.9.0'
end

ruby "2.2.4"
