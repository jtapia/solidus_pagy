# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::StockMovementsController, type: :controller do
  stub_authorization!

  let!(:stock_location) do
    create(
      :stock_location_with_items
    )
  end
  let!(:stock_movement1) do
    create(
      :stock_movement,
      stock_item: stock_location.stock_items.first
    )
  end
  let!(:stock_movement2) do
    create(
      :stock_movement,
      stock_item: stock_location.stock_items.last
    )
  end

  context 'pagination' do
    it 'can page through the promotions' do
      get :index, params: { stock_location_id: stock_location.id, page: 1 }
      expect(assigns[:pagy].page).to eq(1)
      expect(assigns[:pagy].items).to eq(20)
    end
  end

  describe '#index' do
    subject { get :index, params: params }

    context 'with no params' do
      let(:params) { { stock_location_id: stock_location.id } }

      it 'responds with a successful status code' do
        subject

        expect(response).to be_successful
      end

      it 'responds with all the stock locations stock movements' do
        subject

        expect(assigns[:stock_movements]).to contain_exactly(
          stock_movement1,
          stock_movement2
        )
      end
    end

    context 'with search parameters' do
      let(:params) do
        {
          stock_location_id: stock_location.id,
          q: {
            variant_sku_eq: stock_movement1.stock_item.variant.sku
          }
        }
      end

      it 'responds with a successful status code' do
        subject

        expect(response).to be_successful
      end

      it 'responds with the stock movements that match the search criteria' do
        subject

        expect(assigns[:stock_movements]).to contain_exactly(
          stock_movement1,
        )
      end
    end
  end
end
