require "aypex/checkout"

module AypexCheckout
  class << self
    def configuration
      @configuration ||= Aypex::Checkout::Configuration.new
    end

    alias_method :config, :configuration

    def configure
      yield configuration
    end
  end
end
