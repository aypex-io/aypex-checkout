module Aypex
  module Checkout
    class Engine < ::Rails::Engine
      isolate_namespace Aypex
      engine_name "aypex_checkout"

      initializer "aypex.checkout.environment", before: :load_config_initializers do |_app|
        Aypex::Checkout::Config = Aypex::Checkout::Configuration.new
      end

      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), "../../../app/**/aypex/checkout/*_decorator*.rb")).sort.each do |c|
          Rails.application.config.cache_classes ? require(c) : load(c)
        end
      end

      config.to_prepare(&method(:activate).to_proc)
    end
  end
end
