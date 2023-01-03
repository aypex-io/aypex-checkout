# frozen_string_literal: true

module Aypex
  module Checkout
    class Configuration
      attr_writer :cart_route_name, :orders_route_name

      def cart_route_name
        self.cart_route_name = :cart unless @cart_route_name

        @cart_route_name
      end

      def orders_route_name
        self.orders_route_name = :orders unless @orders_route_name

        @orders_route_name
      end
    end
  end
end
