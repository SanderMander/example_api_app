source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'dry-initializer'
gem 'dry-monads'
gem 'jbuilder'
gem 'pg'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
end

group :test do
  gem 'rspec-rails', '~> 4.0.1'

  gem 'database_cleaner-active_record'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
