module Aypex
  module Checkout
    module StateManagment
      private

      def unknown_state?
        (params[:state] && !@order.has_checkout_step?(params[:state])) ||
          (!params[:state] && !@order.has_checkout_step?(@order.state))
      end

      def insufficient_payment?
        params[:state] == "confirm" &&
          @order.payment_required? &&
          @order.payments.valid.sum(:amount) != @order.total
      end

      def correct_state
        if unknown_state?
          @order.checkout_steps.first
        elsif insufficient_payment?
          "payment"
        else
          @order.state
        end
      end

      def ensure_valid_state
        if @order.state != correct_state && !skip_state_validation?
          flash.keep
          @order.update_column(:state, correct_state)
          redirect_to aypex.checkout_state_path(@order.state)
        end
      end

      # Should be overridden if you have areas of your checkout that don't match
      # up to a step within checkout_steps, such as a registration step
      def skip_state_validation?
        false
      end

      def load_order_with_lock
        @order = current_order(lock: true)
        redirect_to(helpers.aypex_checkout_cart_route) && return unless @order
      end

      def ensure_valid_state_lock_version
        if params[:order] && params[:order][:state_lock_version]
          changes = @order.changes if @order.changed?
          @order.reload.with_lock do
            unless @order.state_lock_version == params[:order].delete(:state_lock_version).to_i
              flash[:error] = Aypex.t(:order_already_updated)
              redirect_to(checkout_state_path(@order.state)) && return
            end
            @order.increment!(:state_lock_version)
          end
          @order.assign_attributes(changes) if changes
        end
      end

      def set_state_if_present
        if params[:state]
          redirect_to aypex.checkout_state_path(@order.state) if @order.can_go_to_state?(params[:state]) && !skip_state_validation?
          @order.state = params[:state]
        end
      end

      def setup_for_current_state
        method_name = :"before_#{@order.state}"
        send(method_name) if respond_to?(method_name, true)
      end

      def before_address
        # if the user has a default address, a callback takes care of setting
        # that; but if he doesn't, we need to build an empty one here
        @order.bill_address ||= Address.new(country: current_store.default_country, user: try_aypex_current_user)
        if @order.checkout_steps.include?("delivery")
          @order.ship_address ||= Address.new(country: current_store.default_country,
            user: try_aypex_current_user)
        end

        @bill_address ||= @order.bill_address
        @ship_address ||= @order.ship_address
      end

      def before_delivery
        return if params[:order].present?

        packages = @order.shipments.map(&:to_package)
        @differentiator = Aypex::Stock::Differentiator.new(@order, packages)
      end

      def before_payment
        if @order.checkout_steps.include? "delivery"
          packages = @order.shipments.map(&:to_package)
          @differentiator = Aypex::Stock::Differentiator.new(@order, packages)
          @differentiator.missing.each do |variant, quantity|
            Aypex::Dependency.cart_remove_item_service.constantize.call(order: @order, variant: variant, quantity: quantity)
          end
        end

        return unless try_aypex_current_user.respond_to?(:payment_sources)

        @payment_sources = try_aypex_current_user.payment_sources.where(payment_method: @order.available_payment_methods)
      end
    end
  end
end
