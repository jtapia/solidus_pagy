# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::PricesController, type: :controller do
  stub_authorization!

  let!(:product) { create(:product) }

  context 'with pagination' do
    it 'can page through the product master prices' do
      get :index, params: { product_id: product.slug, page: 1 }
      expect(assigns[:pagy_master_prices].page).to eq(1)
      expect(assigns[:pagy_master_prices].items).to eq(20)
    end

    it 'can page through the product variant prices' do
      get :index, params: { product_id: product.slug, variants_page: 1 }
      expect(assigns[:pagy_variant_prices].page).to eq(1)
      expect(assigns[:pagy_variant_prices].items).to eq(20)
    end
  end

  describe '#index' do
    context 'when only given a product' do
      let(:product) { create(:product) }

      subject { get :index, params: { product_id: product.slug } }

      it { is_expected.to be_successful }

      it 'assigns usable instance variables' do
        subject

        expect(assigns(:search)).to be_a(Ransack::Search)
        expect(assigns(:variant_prices)).to eq(product.prices.for_variant)
        expect(assigns(:master_prices)).to eq(product.prices.for_master)
        expect(assigns(:product)).to eq(product)
      end
    end

    context 'when given a product and a variant' do
      let(:variant) { create(:variant) }
      let(:product) { variant.product }

      subject do
        get :index,
          params: {
            product_id: product.slug,
            variant_id: variant.id
          }
      end

      it { is_expected.to be_successful }

      it 'assigns usable instance variables' do
        subject

        expect(assigns(:search)).to be_a(Ransack::Search)
        expect(assigns(:variant_prices)).to eq(product.prices.for_variant)
        expect(assigns(:master_prices)).to eq(product.prices.for_master)
        expect(assigns(:variant_prices)).to include(variant.default_price)
        expect(assigns(:product)).to eq(product)
      end
    end

    context 'existent product id not given' do
      subject do
        get :index, params: { product_id: 'non-existent-product' }
      end

      it 'cannot find non-existent product' do
        subject

        expect(response).to redirect_to(spree.admin_products_path)
        expect(flash[:error]).to eql('Product is not found')
      end
    end
  end
end
