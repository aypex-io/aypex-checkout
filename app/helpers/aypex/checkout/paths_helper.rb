module Aypex
  module Checkout
    module PathsHelper
      # Provides a localized path to redirect after order completion
      def aypex_checkout_completion_route(order)
        path = "#{AypexCheckout.config.orders_route_name}/#{order.number}"

        path_localizer(path)
      end

      # Provides a localized path to cart
      def aypex_checkout_cart_route(params = {})
        path = AypexCheckout.config.cart_route_name

        path_localizer(path)
      end

      private

      def path_localizer(path)
        if current_locale == current_store.default_locale
          "/#{path}"
        else
          "/#{current_locale + path}/"
        end
      end
    end
  end
end
