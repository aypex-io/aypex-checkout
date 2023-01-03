require "rubygems"
require "rake"
require "rake/testtask"
require "rspec/core/rake_task"
require "aypex/checkout/testing_support/aypex_checkout_rake"

RSpec::Core::RakeTask.new

task default: :spec

desc "Generates a dummy app for testing"
task :test_app do
  ENV["LIB_NAME"] = "aypex/checkout"
  Rake::Task["aypex_checkout:test_app"].execute({install_storefront: false, install_admin: false})
end
