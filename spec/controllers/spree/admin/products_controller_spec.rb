# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::ProductsController, type: :controller do
  stub_authorization!

  let(:product) { create(:product) }

  context 'with pagination' do
    it 'can page through the products' do
      get :index, params: { page: 1, per_page: 10 }
      expect(assigns[:pagy].page).to eq(1)
      expect(assigns[:pagy].items).to eq(10)
    end
  end

  describe '#index' do
    let(:ability_user) do
      stub_model(Spree::LegacyUser, has_spree_role?: true)
    end

    # Regression test for https://github.com/spree/spree/issues/1259
    it 'can find a product by SKU' do
      product = create(:product, sku: 'ABC123')

      get :index, params: { q: { sku_start: 'ABC123' } }
      expect(assigns[:collection]).not_to be_empty
      expect(assigns[:collection]).to include(product)
    end

    # Regression test for https://github.com/spree/spree/issues/1903
    context 'when soft deleted products exist' do
      let!(:soft_deleted_product) { create(:product, sku: 'ABC123') }

      before { soft_deleted_product.discard }

      context 'when params[:q][:with_discarded] is not set' do
        let(:params) { { q: {} } }

        it 'filters out soft-deleted products by default' do
          get :index, params: params
          expect(assigns[:collection]).not_to include(soft_deleted_product)
        end
      end

      context "when params[:q][:with_discarded] is set to 'true'" do
        let(:params) { { q: { with_discarded: 'true' } } }

        it 'includes soft-deleted products' do
          get :index, params: params
          expect(assigns[:collection]).to include(soft_deleted_product)
        end
      end
    end
  end
end
