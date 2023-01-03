module Aypex
  module Checkout
    class PagesController < Aypex::Checkout::BaseController
      before_action :load_cms_page

      def show
      end

      private

      def load_cms_page
        @page = Aypex::CmsPage.for_store(current_store).by_locale(I18n.locale).find_by(slug: params[:slug])
      end
    end
  end
end
