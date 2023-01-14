require "rubygems"
require "standard/rake"
require "rake"
require "rake/testtask"
require "rspec/core/rake_task"
require "testing_support/common_rake"

RSpec::Core::RakeTask.new

task default: :spec

desc "Generates a dummy app for testing"
task :test_app, [:user_class] do |_t, args|
  ENV["LIB_NAME"] = "aypex/checkout"

  Aypex::DummyGeneratorHelper.inject_extension_requirements = true
  Rake::Task["common:test_app"].execute(args.with_defaults(install_emails: false, install_checkout: false, install_admin: false, install_storefront: false))
end
