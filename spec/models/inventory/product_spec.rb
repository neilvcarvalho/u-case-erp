require "rails_helper"

RSpec.describe Inventory::Product, type: :model do
  it "is valid with valid params" do
    product = FactoryBot.create(:inventory_product)

    expect(product).to be_valid
  end
end
