# Set environment to test
ENV["RAILS_ENV"] = "test"

# Load the dummy test application.
begin
  require File.expand_path("../../tmp/dummy/config/environment", __FILE__)
rescue LoadError
  puts "Could not load dummy application. Please ensure you have run `bundle exec rake test_app`"
end

# Load the spec/support files.
Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].sort.each { |f| require f }

# Require the Aypex Developer Tools
require "aypex_dev_tools/rspec/spec_helper"
