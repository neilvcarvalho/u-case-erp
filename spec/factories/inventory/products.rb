FactoryBot.define do
  factory :inventory_product, class: "Inventory::Product" do
    company

    sequence(:name) { |n| "Product #{n}" }
    sequence(:sku)
  end
end
