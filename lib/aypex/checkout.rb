require "aypex"
require "aypex/api"
require "inline_svg"
require "responders"
require "turbo-rails"

require "aypex/checkout/engine"
require "aypex/checkout/configuration"

module Aypex
  module Checkout
    # Used to configure Aypex Checkout.
    #
    # Example:
    #   Aypex::Checkout.config do |config|
    #     config.cart_route_name = 'cart'
    #   end
    def self.configure
      yield(Aypex::Checkout::Config)
    end
  end
end
