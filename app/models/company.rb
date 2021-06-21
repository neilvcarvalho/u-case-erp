class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :inventory_products, class_name: "Inventory::Product", inverse_of: :company
  has_many :inventory_stock_movements, class_name: "Inventory::StockMovement", inverse_of: :company
end
