source 'http://rubygems.org'

gem 'rails', '~> 3.0'
gem 'rake'
gem 'haml-rails'
gem 'jquery-rails'
gem 'pg'

group 'production' do
  gem 'rails_12factor'
end

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.4'
  gem 'test-unit'
  gem 'pry-rails'
end

group :test do
  gem 'rspec-its'
  gem 'shoulda-matchers'
end
