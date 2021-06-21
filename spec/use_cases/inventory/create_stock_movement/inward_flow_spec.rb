require "rails_helper"

describe Inventory::CreateStockMovement::InwardFlow do
  let(:product) { FactoryBot.create(:inventory_product, quantity: 2) }

  context "with valid params" do
    let(:params) { ActionController::Parameters.new(stock_movement: { quantity: "2", total_value_in_cents: "100" }) }

    it "returns a success state" do
      creation = described_class.call(product: product, params: params)

      expect(creation).to be_success
    end

    it "creates a stock movement for the product" do
      expect {
        described_class.call(product: product, params: params)
      }.to change(product.stock_movements, :count).by(1)
    end

    it "creates a stock movement for the company that owns the product" do
      expect {
        described_class.call(product: product, params: params)
      }.to change(product.company.inventory_stock_movements, :count).by(1)
    end

    it "does not change the product" do
      expect {
        described_class.call(product: product, params: params)
      }.not_to change { product }
    end
  end

  context "when the stock movement quantity is not a number" do
    let(:params) { ActionController::Parameters.new(stock_movement: { quantity: "dog", total_value_in_cents: "100" }) }

    it "returns a failure as invalid_stock_movement" do
      creation = described_class.call(product: product, params: params)

      expect(creation.type).to eq :invalid_stock_movement
    end
  end
end
