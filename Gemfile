source 'http://rubygems.org'

# ruby '2.6.3'

# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '>= 3.12.4'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '>= 2.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '>= 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '>= 3.1.7'

gem 'loofah', '>= 2.3.1'
gem 'nokogiri', '>= 1.8.1'
gem 'rails-html-sanitizer', '>= 1.0.4'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

# To protect our API from DDoS, brute force attacks, hammering, or even to monetize with paid usage limits
gem 'rack-attack'

gem 'geocoder', ">= 1.6.1"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Use RSpec for specs
  gem 'rspec-rails', '>= 3.1.0'

  # Use Factory Girl for generating random test data
  gem 'factory_girl_rails'
end

group :development do
  gem 'listen', '>= 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '>= 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
