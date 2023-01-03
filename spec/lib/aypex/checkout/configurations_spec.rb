require "spec_helper"

RSpec.describe Aypex::Checkout::Configuration do
  subject(:test_subject) { described_class.new }

  describe "#cart_route_name" do
    it "returns cart" do
      expect(test_subject.cart_route_name).to be_a(Symbol)
    end

    it "is settable" do
      expect(test_subject.cart_route_name).to eq(:cart)

      test_subject.cart_route_name = :basket

      expect(test_subject.cart_route_name).to eq(:basket)
    end
  end

  describe "#orders_route_name" do
    it "returns cart" do
      expect(test_subject.orders_route_name).to be_a(Symbol)
    end

    it "is settable" do
      expect(test_subject.orders_route_name).to eq(:orders)

      test_subject.orders_route_name = :completed_orders

      expect(test_subject.orders_route_name).to eq(:completed_orders)
    end
  end
end
