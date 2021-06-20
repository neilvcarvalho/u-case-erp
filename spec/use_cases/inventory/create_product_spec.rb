require "rails_helper"

describe Inventory::CreateProduct do
  let(:company) { FactoryBot.create(:company) }

  context "with valid params" do
    let(:params) { ActionController::Parameters.new(product: { sku: "1", name: "Product" }) }

    it "returns a success state" do
      creation = described_class.call(company: company, params: params)

      expect(creation).to be_success
    end

    it "creates a product for the provided company" do
      expect {
        described_class.call(company: company, params: params)
      }.to change(company.inventory_products, :count).by(1)
    end

    it "returns the created product as the result" do
      creation = described_class.call(company: company, params: params)
      product = creation.data[:product]

      expect(product.name).to eq "Product"
    end
  end

  context "without the `product` parameter" do
    let(:params) { ActionController::Parameters.new(sku: "1", name: "Product") }

    it "returns a failure as parameter_missing" do
      creation = described_class.call(company: company, params: params)

      expect(creation.type).to eq :parameter_missing
    end

    it "returns the error as the result" do
      creation = described_class.call(company: company, params: params)

      expect(creation.data[:message]).to include "param is missing"
    end
  end
end
