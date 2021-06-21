FactoryBot.define do
  factory :inventory_stock_movement, class: "Inventory::StockMovement" do
    product { create(:inventory_product) }
  end
end
