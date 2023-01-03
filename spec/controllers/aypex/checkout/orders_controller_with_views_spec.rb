require "spec_helper"

describe Aypex::Checkout::OrdersController, type: :controller do
  render_views

  let(:token) { "some_token" }
  let(:user) { stub_model(Aypex::LegacyUser) }
  let(:store) { Aypex::Store.default }

  before do
    allow(controller).to receive_messages aypex_current_user: user
    allow(controller).to receive_messages try_aypex_current_user: user
  end

  # Regression test for #3246
  context "when using GBP" do
    before do
      store.update(default_currency: "GBP")
    end

    context "when order is in delivery" do
      before do
        # Using a let block won't acknowledge the currency setting
        # Therefore we just do it like this...
        order = OrderWalkthrough.up_to(:delivery)
        allow(controller).to receive_messages current_order: order
      end

      it "displays rate cost in correct currency" do
        get :edit
        html = Nokogiri::HTML(response.body)
        expect(html.css(".rate-cost").text).to eq "£10.00"
      end
    end
  end
end
