require "rails_helper"

describe Inventory::ConfirmStockMovement do
  include ActiveSupport::Testing::TimeHelpers

  let(:product) { FactoryBot.create(:inventory_product, quantity: 3, reserved_quantity: 2) }

  context "with valid arguments" do
    let(:stock_movement) { FactoryBot.create(:inventory_stock_movement, quantity: -1, product: product) }

    it "returns a success state" do
      confirmation = described_class.call(stock_movement: stock_movement, confirmation_time: DateTime.current)

      expect(confirmation).to be_success
    end

    it "confirms the stock movement at the specified time" do
      specified_time = DateTime.parse("2020-01-01T08:00:00-03:00")

      expect {
        described_class.call(stock_movement: stock_movement,
                             confirmation_time: specified_time)
      }.to change(stock_movement, :confirmed_at).to(specified_time)
    end
  end

  context "when the stock movement is outward" do
    let(:stock_movement) { FactoryBot.create(:inventory_stock_movement, quantity: -1, product: product) }

    it "decreases the product's reserved quantity" do
      expect {
        described_class.call(stock_movement: stock_movement,
                             confirmation_time: DateTime.current)
      }.to change(product, :reserved_quantity).by(-1)
    end

    it "decreases the product's quantity" do
      expect {
        described_class.call(stock_movement: stock_movement,
                             confirmation_time: DateTime.current)
      }.to change(product, :quantity).by(-1)
    end

    it "changes the stock movement confirmation time" do
      expect {
        described_class.call(stock_movement: stock_movement,
                             confirmation_time: DateTime.current)
      }.to change(stock_movement, :confirmed_at).from(nil)
    end
  end

  context "when the stock movement is inward" do
    let(:stock_movement) { FactoryBot.create(:inventory_stock_movement, quantity: 1, product: product) }

    it "does not change the product's reserved quantity" do
      expect {
        described_class.call(stock_movement: stock_movement,
                             confirmation_time: DateTime.current)
      }.not_to change(product, :reserved_quantity)
    end

    it "increases the product's quantity" do
      expect {
        described_class.call(stock_movement: stock_movement,
                             confirmation_time: DateTime.current)
      }.to change(product, :quantity).by(1)
    end

    it "changes the stock movement confirmation time" do
      expect {
        described_class.call(stock_movement: stock_movement,
                             confirmation_time: DateTime.current)
      }.to change(stock_movement, :confirmed_at).from(nil)
    end
  end

  context "when the stock movement is already confirmed" do
    let(:stock_movement) {
      FactoryBot.create(:inventory_stock_movement, quantity: 1, product: product, confirmed_at: DateTime.current)
    }

    it "returns a failure as already_confirmed", :aggregate_failures do
      confirmation = described_class.call(stock_movement: stock_movement, confirmation_time: DateTime.current)

      expect(confirmation).to be_failure
      expect(confirmation.type).to eq :already_confirmed
    end
  end
end
