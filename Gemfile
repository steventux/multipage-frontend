source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '5.0.4'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc',        group: :doc

gem 'gds-api-adapters', '26.6.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


gem "unicorn", "5.0.1"
gem "logstasher", "0.6.2"
group :development, :test do
  gem "rspec-rails", "3.4.0"
end

group :development, :test do
  gem "simplecov", "0.10.0", require: false
  gem "simplecov-rcov", "0.2.3", require: false
end

group :test do
  gem "webmock", "1.21.0"
end

gem "plek", "1.11.0"
gem "airbrake", "4.2.1"
