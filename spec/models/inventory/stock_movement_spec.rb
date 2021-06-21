require "rails_helper"

RSpec.describe Inventory::StockMovement, type: :model do
  it "is valid with valid params" do
    stock_movement = FactoryBot.create(:inventory_stock_movement)

    expect(stock_movement).to be_valid
  end

  describe "#confirmed?" do
    context "when the confirmed_at exists" do
      subject(:stock_movement) { described_class.new(confirmed_at: DateTime.current) }

      it { is_expected.to be_confirmed }
    end

    context "when the confirmed_at does not exist" do
      subject(:stock_movement) { described_class.new(confirmed_at: nil) }

      it { is_expected.not_to be_confirmed }
    end
  end
end
