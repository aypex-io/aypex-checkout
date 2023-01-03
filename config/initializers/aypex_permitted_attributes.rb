module Aypex
  module PermittedAttributes
    @@checkout_attributes << :use_shipping
    @@store_attributes << [:checkout_shipping_instructions, :checkout_coupon_codes_enabled]
  end
end
