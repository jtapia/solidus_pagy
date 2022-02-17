# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::VariantsController, type: :controller do
  stub_authorization!

  let!(:product) { create(:product) }

  context 'with pagination' do
    it 'can page through the promotions' do
      get :index, params: { product_id: product.slug, page: 1 }
      expect(assigns[:pagy].page).to eq(1)
      expect(assigns[:pagy].items).to eq(20)
    end
  end

  describe '#index' do
    let(:params) { { product_id: product.slug } }

    subject { get :index, params: params }

    context 'when the value of @parent' do
      it 'is the product' do
        subject
        expect(assigns(:parent)).to eq product
      end

      context 'with a deleted product' do
        before { product.discard }

        it 'is the product' do
          subject
          expect(assigns(:parent)).to eq product
        end
      end
    end

    context 'when the value of @collection' do
      let!(:variant) { create(:variant, product: product) }
      let!(:deleted_variant) { create(:variant, product: product) }

      context 'with soft-deleted variants' do
        before { deleted_variant.discard }

        context 'when deleted is not requested' do
          it 'excludes deleted variants' do
            subject
            expect(assigns(:collection)).to include variant
            expect(assigns(:collection)).not_to include deleted_variant
          end
        end

        context 'when deleted is requested' do
          let(:params) { { product_id: product.slug, deleted: 'on' } }

          it 'includes deleted variants' do
            subject
            expect(assigns(:collection)).to include variant
            expect(assigns(:collection)).to include deleted_variant
          end
        end

        context 'when existent product id not given' do
          let(:params) { { product_id: 'non-existent-product' } }

          it 'cannot find non-existent product' do
            subject
            expect(response).to redirect_to(spree.admin_products_path)
            expect(flash[:error]).to eql('Product is not found')
          end
        end
      end
    end
  end
end
