module Aypex
  module Checkout
    class BootstrapBuilder < ActionView::Helpers::FormBuilder
      include ActionView::Helpers::TagHelper
      include ActionView::Context

      def field_container(method, options = {}, &block)
        @template.field_container(@object_name, method, options, &block)
      end

      def error_message_on(method, options = {})
        @template.error_message_on(@object_name, method, objectify_options(options))
      end

      def label(method, text = nil, options = {})
        super(method, text, options.reverse_merge(class: "form-label"))
      end

      def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
        super(method, options.reverse_merge(class: "form-check-input", data: {form__state_target: "watch"}), checked_value, unchecked_value)
      end

      def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
        super(method, collection, value_method, text_method, options, html_options.reverse_merge(class: "form-select", data: {controller: "ts--select", form__state_target: "watch"}))
      end

      def number_field(method, options = {})
        super(method, options.reverse_merge(placeholder: method.to_s.capitalize, class: "form-control", data: {controller: "input--format-integer", form__state_target: "watch"}))
      end

      def radio_button(method, tag_value, options = {})
        super(method, tag_value, options.reverse_merge(class: "form-check-input", data: {form__state_target: "watch"}))
      end

      def text_field(method, options = {})
        super(method, options.reverse_merge(placeholder: method.to_s.capitalize, class: "form-control", data: {form__state_target: "watch"}, autocomplete: "off"))
      end

      def email_field(method, options = {})
        super(method, options.reverse_merge(placeholder: method.to_s.capitalize, class: "form-control", data: {form__state_target: "watch"}, autocomplete: "off"))
      end

      def password_field(method, options = {})
        super(method, options.reverse_merge(placeholder: method.to_s.capitalize, class: "form-control", data: {form__state_target: "watch"}, autocomplete: "off"))
      end

      def phone_field(method, options = {})
        super(method, options.reverse_merge(placeholder: method.to_s.capitalize, class: "form-control", data: {form__state_target: "watch"}, autocomplete: "off"))
      end

      def text_area(method, options = {})
        super(method, options.reverse_merge(placeholder: method.to_s.capitalize, class: "form-control", data: {form__state_target: "watch"}))
      end

      def select(object_name, method_name, template_object, options = {}, &block)
        super(object_name, method_name, template_object, options.reverse_merge(class: "form-select", data: {form__state_target: "watch"}, &block))
      end

      def file_field(method, options = {})
        super(method, options.reverse_merge(class: "form-control", data: {form__state_target: "watch"}))
      end

      ActionView::Base.field_error_proc = proc do |html_tag, instance|
        html = ""

        form_fields = [
          "textarea",
          "input",
          "select"
        ]

        elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, " + form_fields.join(", ")

        elements.each do |e|
          if e.node_name.eql? "label"
            html = e.to_s.html_safe
          elsif form_fields.include? e.node_name
            e["class"] += " is-invalid"
            html = if instance.error_message.is_a?(Array)
              %(#{e}<div class="invalid-feedback">#{instance.error_message.uniq.join(", ")}</div>).html_safe
            else
              %(#{e}<div class="invalid-feedback">#{instance.error_message}</div>).html_safe
            end
          end
        end
        html
      end
    end
  end
end
