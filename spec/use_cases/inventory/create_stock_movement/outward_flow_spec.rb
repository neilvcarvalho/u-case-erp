require "rails_helper"

describe Inventory::CreateStockMovement::OutwardFlow do
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

    it "creates a stock movement with negative quantity" do
      creation = described_class.call(product: product, params: params)

      expect(creation.data[:stock_movement].quantity).to be_negative
    end

    it "increases the product reserved quantity" do
      expect {
        described_class.call(product: product, params: params)
      }.to change(product, :reserved_quantity).by(2)
    end
  end

  context "when the stock movement quantity is higher than the product available quantity" do
    let(:product) { FactoryBot.create(:inventory_product, quantity: 2, reserved_quantity: 1) }
    let(:params) { ActionController::Parameters.new(stock_movement: { quantity: "2", total_value_in_cents: "100" }) }

    it "returns a failure as invalid_stock_movement" do
      creation = described_class.call(product: product, params: params)

      expect(creation.type).to eq :invalid_stock_movement
    end

    it "does not create any stock movement" do
      described_class.call(product: product, params: params)

      expect(Inventory::StockMovement.count).to eq 0
    end

    it "does not change the product reserved quantity" do
      described_class.call(product: product, params: params)

      expect(product.reload.reserved_quantity).to eq 1
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
