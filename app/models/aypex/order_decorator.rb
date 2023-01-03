module Aypex
  module OrderDecorator
    def self.prepended(base)
      base.before_validation :clone_shipping_address, if: :use_shipping?
      base.attr_accessor :use_shipping
    end

    private

    def use_shipping?
      use_shipping.in?([true, "true", "1"])
    end

    ::Aypex::Order.prepend self if ::Aypex::Order.included_modules.exclude?(self)
  end
end
