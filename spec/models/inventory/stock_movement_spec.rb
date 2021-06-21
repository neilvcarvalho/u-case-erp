require "rails_helper"

RSpec.describe Inventory::StockMovement, type: :model do
  it "is valid with valid params" do
    stock_movement = FactoryBot.create(:inventory_stock_movement)

    expect(stock_movement).to be_valid
  end
end
