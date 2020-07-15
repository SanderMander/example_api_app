source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'pg'
gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'dry-initializer'
gem 'dry-monads'
gem 'jbuilder'

group :development, :test do
  gem 'pry-byebug'
  gem 'factory_bot_rails'
end

group :test do
  gem 'rspec-rails', '~> 4.0.1'
  gem 'faker'
  gem 'database_cleaner-active_record'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
