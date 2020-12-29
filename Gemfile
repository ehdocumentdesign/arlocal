source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.7'

gem 'bcrypt', '~> 3.1'
gem 'bootsnap', '~> 1.5', require: false    # Reduces boot times through caching; required in config/boot.rb
gem 'coffee-rails', '~> 5.0'
gem 'commonmarker', '~> 0.21'
gem 'devise', '~> 4.7'
gem 'exiftool_vendored', '~> 12.11'
gem 'haml', '~> 5.2'
gem 'jquery-rails', '~> 4.4'   # jPlayer requires jquery
gem 'mediainfo', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6'
gem 'rb-readline', '~> 0.5'
gem 'sassc-rails', '~> 2.1'
# A&R.Local still uses Sprockets for javascript asset compilation. There is not enough front-end javascript to justify webpacker.
gem 'sprockets', '~> 4.0'     # A&R.Local requires sprockets version 4
gem 'sqlite3', '~> 1.4'
gem 'turbolinks', '~> 5.2'
gem 'uglifier', '~> 4.2'
gem 'unicorn', '~> 5.7'


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '~> 4'
  gem 'listen', '~> 3.2'
  # Not using Spring
  # (Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring)
  # gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0'
end

group :test do
  gem 'capybara', '~> 3.34'
  gem 'webdrivers', '~> 4.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
