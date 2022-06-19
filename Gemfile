source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>= 3'

gem 'bcrypt', '~> 3.1'
gem 'bootsnap', '~> 1.12', require: false    # Reduces boot times through caching; required in config/boot.rb
gem 'coffee-rails', '~> 5.0'
gem 'commonmarker', '~> 0.23'
gem 'devise', '~> 4.8'
gem 'exiftool_vendored', '~> 12.42'
gem 'friendly_id', '~> 5.4', '>= 5.4.2'
gem 'haml', '~> 5.2'
gem 'jquery-rails', '~> 4.5'   # jPlayer requires jquery
gem 'mediainfo', '~> 1.5'
gem 'puma', '~> 5.6'
gem 'rails', '~> 7.0'
gem 'rb-readline', '~> 0.5'
# Sometimes not included in ruby stdlib
# gem 'rexml', '~> 3.2'
gem 'sassc-rails', '~> 2.1'
# A&R.Local still uses Sprockets for javascript asset compilation. There is not enough front-end javascript to justify webpacker.
gem 'sprockets', '~> 4.0'     # A&R.Local requires sprockets version 4
gem 'sqlite3', '~> 1.4'
gem 'turbolinks', '~> 5.2'
gem 'uglifier', '~> 4.2'
gem 'unicorn', '~> 6.1'


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '~> 4'
  gem 'listen', '~> 3.7'
  # Not using Spring
  # (Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring)
  # gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0'
end

group :test do
  gem 'capybara', '~> 3.37'
  gem 'webdrivers', '~> 5.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
