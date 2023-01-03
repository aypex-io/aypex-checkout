module Aypex
  module Checkout
    module ProductsHelper
      def aypex_checkout_product_image_tag(variant, options = {})
        image = default_image_for_product_or_variant(variant)

        img = if image.present?
          options[:alt] = image.alt.blank? ? variant.name : image.alt
          image_tag main_app.cdn_image_url(image.url(:medium)), options
        else
          aypex_checkout_svg_tag "missing-image.svg", class: "noimage", size: "60%*60%"
        end

        content_tag(:div, img, class: "product-image-inner")
      end
    end
  end
end
