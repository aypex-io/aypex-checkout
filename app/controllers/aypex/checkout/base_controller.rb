module Aypex
  module Checkout
    class BaseController < ApplicationController
      include Aypex::ControllerHelpers::Auth
      include Aypex::ControllerHelpers::Search
      include Aypex::ControllerHelpers::Store
      include Aypex::ControllerHelpers::StrongParameters
      include Aypex::ControllerHelpers::Locale
      include Aypex::ControllerHelpers::Currency
      include Aypex::ControllerHelpers::Order
      include Aypex::Checkout::LocaleUrls

      respond_to :html

      helper "aypex/base"
      helper "aypex/locale"
      helper "aypex/currency"

      helper_method :title

      skip_before_action :verify_authenticity_token, only: :ensure_cart, raise: false

      before_action :redirect_to_default_locale

      protected

      default_form_builder(Aypex::Checkout::BootstrapBuilder)

      def title
        "#{current_store.name} | #{I18n.t("aypex_checkout.secure_checkout")}"
      end

      def redirect_unauthorized_access
        if try_aypex_current_user
          flash[:error] = Aypex.t(:authorization_failure)
          redirect_to aypex.checkout_forbidden_path
        else
          store_location
          if respond_to?(:aypex_login_path)
            redirect_to aypex_login_path
          else
            redirect_to aypex.checkout_root_path
          end
        end
      end
    end
  end
end
