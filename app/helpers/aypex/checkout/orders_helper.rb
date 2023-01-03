module Aypex
  module Checkout
    module OrdersHelper
      def aypex_checkout_available_payment_methods
        @aypex_checkout_available_payment_methods ||= @order.available_payment_methods
      end
    end
  end
end
