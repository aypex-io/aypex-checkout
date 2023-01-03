source "https://rubygems.org"

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw]

%w[
  actionmailer actionpack actionview activejob activemodel activerecord
  activestorage activesupport railties
].each do |rails_gem|
  gem rails_gem, ENV.fetch("RAILS_VERSION", "~> 7.0.0"), require: false
end

platforms :jruby do
  gem "jruby-openssl"
end

platforms :ruby do
  if ENV["DB"] == "mysql"
    gem "mysql2"
  else
    gem "pg", "~> 1.1"
  end
end

group :test do
  gem "capybara", "~> 3.24"
  gem "capybara-screenshot", "~> 1.0"
  gem "database_cleaner", "~> 2.0"
  gem "email_spec"
  gem "factory_bot_rails", "~> 6.0"
  gem "ffaker"
  gem "propshaft"
  gem "puma", "~> 5.0"
  gem "redis"
  gem "rspec-activemodel-mocks", "~> 1.0"
  gem "rspec-rails", "~> 5.0"
  gem "rspec-retry"
  gem "rspec_junit_formatter"
  gem "rswag-specs"
  gem "rails-controller-testing"
  gem "timecop"
  gem "webdrivers", "~> 5.0"
  gem "webmock", "~> 3.7"
end

group :test, :development do
  gem "gem-release"
  gem "i18n-tasks"
  gem "rubocop", "1.40.0"
  gem "standard"
end

aypex_opts = {github: "aypex/aypex", branch: ENV.fetch("AYPEX_BRANCH", "main")}
gem "aypex_core", aypex_opts
gem "aypex_api", aypex_opts

gemspec
