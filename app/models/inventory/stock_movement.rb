class Inventory::StockMovement < ApplicationRecord
  belongs_to :product, class_name: "Inventory::Product", foreign_key: :inventory_product_id,
                       inverse_of: :stock_movements
  belongs_to :company, inverse_of: :inventory_stock_movements

  validates :quantity, presence: true, numericality: true
  validates :total_value_in_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :assign_company, on: :create

  private

  def assign_company
    self.company ||= product.company
  end
end
