# The Inventory::StockMovement class is responsible for the persistence of product stock movements.
#
# Records **must not** be created or updated directly.
#
# Stock movements **must** be created using the public interface of the Inventory::CreateStockMovement module.
# Stock movement confirmations **must** be created using public interface of the Inventory::ConfirmStockMovement module.

class Inventory::StockMovement < ApplicationRecord
  belongs_to :product, class_name: "Inventory::Product", foreign_key: :inventory_product_id,
                       inverse_of: :stock_movements
  belongs_to :company, inverse_of: :inventory_stock_movements

  validates :quantity, presence: true, numericality: true
  validates :total_value_in_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :assign_company, on: :create

  def confirmed?
    confirmed_at.present?
  end

  private

  def assign_company
    self.company ||= product.company
  end
end
