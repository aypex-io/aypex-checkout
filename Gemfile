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

if ENV["DB"] == "mysql"
  gem "mysql2"
else
  gem "pg", "~> 1.1"
end

group :test, :development do
  gem "aypex_dev_tools", github: "aypex-io/aypex_dev_tools"
  gem "debug"
  gem "propshaft"
end

gem "aypex", github: "aypex-io/aypex"
gem "aypex-api", github: "aypex-io/aypex-api"

gemspec
