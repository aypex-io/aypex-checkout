module Aypex
  module Checkout
    module BaseHelper
      include PathsHelper
      include ProductsHelper

      def aypex_checkout_toaste_class(kind: :notice)
        if kind == :error
          "text-bg-danger"
        else
          "text-bg-dark"
        end
      end

      def aypex_checkout_accordion_show_hide(index)
        if index == 0
          "show"
        else
          ""
        end
      end

      def aypex_checkout_product_images(product, variants)
        if product.variants_and_option_values(current_currency).any?
          variants_without_master_images = variants.reject(&:is_master).map(&:images).flatten

          if variants_without_master_images.any?
            return variants_without_master_images
          end
        end

        variants.map(&:images).flatten
      end

      def aypex_checkout_express_checkout_payment_methods
        aypex_checkout_available_payment_methods.select(&:hosted_checkout?)
      end

      def aypex_checkout_flash_messages(opts = {})
        return unless flash.present?

        render "aypex/checkout/shared/toast", message: flash.first[1], kind: flash.first[0]
      end

      def aypex_checkout_logo(image_path = nil, options = {})
        logo_attachment = if defined?(Aypex::StoreLogo) && current_store.logo.is_a?(Aypex::StoreLogo)
          current_store.logo.attachment # Aypex v5
        else
          current_store.logo # Aypex 4.x
        end

        image_path ||= if logo_attachment&.attached? && logo_attachment&.variable?
          main_app.cdn_image_url(logo_attachment.variant(resize: "244x104>"))
        elsif logo_attachment&.attached? && logo_attachment&.image?
          main_app.cdn_image_url(current_store.logo)
        else
          asset_path("aypex/checkout/aypex-logo.svg")
        end

        path = aypex.respond_to?(:checkout_root_path) ? aypex.checkout_root_path : main_app.checkout_root_path

        link_to path, "aria-label": current_store.name, method: options[:method] do
          image_tag image_path, alt: current_store.name, title: current_store.name
        end
      end

      def aypex_checkout_svg_tag(file_name, options = {})
        prefixed_file = "aypex/checkout/#{file_name}"

        inline_svg_tag(prefixed_file, options)
      end

      def aypex_checkout_checkout_progress_line
        states = @order.checkout_steps
        items = states.each_with_index.map do |state, i|
          text = I18n.t("aypex.checkout.order_state.#{state}").titleize

          css_classes = []
          current_index = states.index(@order.state)
          state_index = states.index(state)

          css_classes << "next" if state_index == current_index + 1
          css_classes << "active" if state == @order.state
          css_classes << "first" if state_index == 0
          css_classes << "last" if state_index == states.length - 1

          if state_index < current_index
            css_classes << "completed"
            text = link_to text, checkout_state_path(state), class: css_classes.join(" ")
          end

          if state_index > current_index
            content_tag("span", text, class: "cart-progress text-muted")
          else
            content_tag("span", text, class: "cart-progress")
          end
        end

        content_tag(:div, raw("<span class='cart-progress'><a href='#{aypex_checkout_cart_route}' class='completed'>#{I18n.t("aypex.checkout.cart")}</a></span>" + items.join("")),
          class: "steps-container text-center step-#{@order.state}", id: "checkout-steps")
      end

      def aypex_checkout_next_step_name
        states = @order.checkout_steps
        states.each_with_index.map do |state, _i|
          current_index = states.index(@order.state)
          state_index = states.index(state)

          return state if state_index == current_index + 1
        end
      end

      def aypex_checkout_previous_step_name
        states = @order.checkout_steps
        states.each_with_index.map do |state, _i|
          current_index = states.index(@order.state)
          state_index = states.index(state)

          return state if state_index == current_index - 1
        end
      end

      def aypex_checkout_menu(location = "checkout_footer")
        method_name = "for_#{location}"

        if available_menus.respond_to?(method_name) && Aypex::Menu::MENU_LOCATIONS_PARAMETERIZED.include?(location)
          available_menus.send(method_name, I18n.locale) || current_store.default_menu(location)
        end
      end

      def aypex_checkout_aypex_nav_link_tag(item, opts = {}, &block)
        if item.new_window
          target = opts[:target] || "_blank"
          rel = opts[:rel] || "noopener noreferrer"
        end

        active_class = if request && current_page?(aypex_checkout_aypex_localized_link(item))
          "active #{opts[:class]}"
        else
          opts[:class]
        end

        link_opts = {target: target, rel: rel, class: active_class, id: opts[:id], data: opts[:data], aria: opts[:aria]}

        if block
          link_to aypex_checkout_aypex_localized_link(item), link_opts, &block
        else
          link_to item.name, aypex_checkout_aypex_localized_link(item), link_opts
        end
      end

      private

      def aypex_checkout_aypex_localized_link(item)
        return if item.link.nil?

        output_locale = if locale_param
          "/#{I18n.locale}"
        end

        if ["Aypex::CmsPage"].include?(item.linked_resource_type)
          output_locale.to_s + "checkout" + item.link
        else
          item.link
        end
      end
    end
  end
end
