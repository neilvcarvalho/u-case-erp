# The CreateProduct class is responsible for creating products in the inventory.
#
# This class **may** be used in any module and is part of the Inventory public interface.

class Inventory::CreateProduct < Micro::Case
  flow call!

  attributes :company, :params

  validates :company, kind: Company
  validates :params, kind: ActionController::Parameters

  def call!
    product_params = params.require(:product).permit(:sku, :name, :description)

    product = company.inventory_products.create!(product_params)

    Success result: { product: product }
  rescue ActiveRecord::RecordInvalid => e
    Failure :invalid_product, result: { errors: e.record.errors }
  rescue ActionController::ParameterMissing => e
    Failure :parameter_missing, result: { message: e.message }
  end
end
