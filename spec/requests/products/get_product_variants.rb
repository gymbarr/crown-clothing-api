require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET /api/categories/:category_title/products/:id/show_variants' do
    subject(:get_product_variants_request) do
      get "/api/categories/#{category.title}/products/#{product.id}/show_variants", params:
    end

    let(:category) { create :category }
    let!(:product) { create :product, category: }
    let!(:filtered_variants) { create_list :variant, 3, color: 'some_color', product: }

    before do
      create_list(:variant, 5, product:)
      get_product_variants_request
    end

    context 'when variants filter parameters is blank' do
      let(:params) { {} }
      let(:all_variants_json) do
        JSON.parse(Panko::ArraySerializer.new(product.variants,
                                              each_serializer: PankoSerializers::VariantSerializer).to_json)
      end

      it 'returns all available product variants' do
        expect(json).to match_array(all_variants_json)
      end
    end

    context 'when variants filter parameters is not blank' do
      let(:filtered_variants_json) do
        JSON.parse(Panko::ArraySerializer.new(filtered_variants,
                                              each_serializer: PankoSerializers::VariantSerializer).to_json)
      end
      let(:params) { { attrs: { color: 'some_color' } } }

      it 'returns only filtered product variants' do
        expect(json).to match_array(filtered_variants_json)
      end
    end
  end
end
