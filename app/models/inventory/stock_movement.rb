class Inventory::StockMovement < ApplicationRecord
  belongs_to :product, class_name: "Inventory::Product"
  belongs_to :company

  validates :quantity, presence: true, numericality: { minimum: 0 }
  validates :total_value_in_cents, presence: true, numericality: { minimum: 0 }
end
