module Aypex
  module Checkout
    module AddressesHelper
      def aypex_checkout_state_label(country)
        case country.iso3
        when "ARE"
          I18n.t("aypex_checkout.emirate")
        when "AUS"
          I18n.t("aypex_checkout.state_territory")
        else
          I18n.t("aypex_checkout.state")
        end
      end

      def aypex_checkout_zipcode_label(country)
        case country.iso3
        when "GBR"
          I18n.t("aypex_checkout.post_code")
        when "CAN"
          I18n.t("aypex_checkout.post_code")
        when "AUS"
          I18n.t("aypex_checkout.post_code")
        else
          I18n.t("aypex_checkout.zipcode")
        end
      end

      def aypex_checkout_required_span_tag(required = true)
        if required
          content_tag(:span, " *", class: "required text-danger")
        else
          ""
        end
      end

      def aypex_checkout_states_field_present?(country)
        country.states_required? || country.states.any?
      end

      def aypex_checkout_city_field_class(country)
        aypex_checkout_zip_field_class(country)
      end

      def aypex_checkout_zip_field_class(country)
        if aypex_checkout_states_field_present?(country)
          "col-4"
        else
          "col-6"
        end
      end

      def aypex_checkout_user_available_addresses
        @aypex_checkout_user_available_addresses ||= begin
          return [] unless try_aypex_current_user

          states = current_store.countries_available_for_checkout.each_with_object([]) do |country, memo|
            memo << current_store.states_available_for_checkout(country)
          end.flatten

          try_aypex_current_user.addresses
            .where(country_id: states.pluck(:country_id).uniq)
        end
      end
    end
  end
end