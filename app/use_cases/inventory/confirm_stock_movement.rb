# The ConfirmStockMovement class is responsible for confirming a stock movement.
#
# This class **may** be used in any module and is part of the Inventory public interface.

class Inventory::ConfirmStockMovement < Micro::Case
  flow call!

  attributes :stock_movement, :confirmation_time

  validates :stock_movement, kind: Inventory::StockMovement
  validates :confirmation_time, kind: DateTime, presence: true

  def call!
    product = stock_movement.product

    product.with_lock do
      stock_movement.lock!

      return Failure(:already_confirmed) if stock_movement.confirmed?

      stock_movement.update!(confirmed_at: confirmation_time)
      product.quantity += stock_movement.quantity
      product.reserved_quantity += stock_movement.quantity if stock_movement.quantity.negative?
      product.save!
    end

    Success result: { stock_movement: stock_movement }
  rescue ActiveRecord::RecordInvalid => e
    Failure :invalid_product, result: { errors: e.record.errors }
  end
end
