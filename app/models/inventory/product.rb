# The Inventory::Product class is responsible for the persistence of products.
#
# Records **must not** be created or updated directly.

class Inventory::Product < ApplicationRecord
  belongs_to :company, inverse_of: :inventory_products
  has_many :stock_movements, class_name: "Inventory::StockMovement", foreign_key: :inventory_product_id,
                             inverse_of: :product, dependent: :destroy

  validates :reserved_quantity, numericality: { greater_than_or_equal_to: 0,
                                                less_than_or_equal_to: ->(product) { product.quantity } }
  validates :name, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :sku, presence: true, uniqueness: { scope: :company_id }

  def available_quantity
    quantity - reserved_quantity
  end
end
