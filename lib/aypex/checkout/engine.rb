module Aypex
  module Checkout
    class Engine < ::Rails::Engine
      isolate_namespace Aypex
      engine_name "aypex_checkout"

      initializer "aypex.checkout.environment", before: :load_config_initializers do |_app|
        Aypex::Checkout::Config = Aypex::Checkout::Configuration.new
      end

      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), "../../../app/**/aypex/*_decorator*.rb")).sort.each do |c|
          Rails.application.config.cache_classes ? require(c) : load(c)
        end
      end

      def self.admin_available?
        @admin_available ||= ::Rails::Engine.subclasses.map(&:instance).map { |e| e.class.to_s }.include?('Aypex::Admin::Engine')
      end

      def self.api_available?
        @api_available ||= ::Rails::Engine.subclasses.map(&:instance).map { |e| e.class.to_s }.include?('Aypex::Api::Engine')
      end

      def self.cli_available?
        @cli_available ||= ::Rails::Engine.subclasses.map(&:instance).map { |e| e.class.to_s }.include?('Aypex::Cli::Engine')
      end

      def self.emails_available?
        @emails_available ||= ::Rails::Engine.subclasses.map(&:instance).map { |e| e.class.to_s }.include?('Aypex::Emails::Engine')
      end

      def self.sample_available?
        @sample_available ||= ::Rails::Engine.subclasses.map(&:instance).map { |e| e.class.to_s }.include?('AypexSample::Engine')
      end

      def self.storefront_available?
        @storefront_available ||= ::Rails::Engine.subclasses.map(&:instance).map { |e| e.class.to_s }.include?('Aypex::Storefront::Engine')
      end

      config.to_prepare(&method(:activate).to_proc)
    end
  end
end
