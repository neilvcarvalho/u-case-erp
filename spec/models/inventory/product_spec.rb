require "rails_helper"

RSpec.describe Inventory::Product, type: :model do
  it "is valid with valid params" do
    product = FactoryBot.create(:inventory_product)

    expect(product).to be_valid
  end

  describe "#available quantity" do
    it "returns the quantity minus the reserved quantity" do
      product = FactoryBot.build(:inventory_product, quantity: 10, reserved_quantity: 8)

      expect(product.available_quantity).to eq 2
    end
  end
end
