# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::StockItemsController, type: :controller do
  stub_authorization!

  let(:stock_location) { create(:stock_location) }

  context 'pagination' do
    it 'can page through the promotions' do
      get :index, params: { page: 1 }
      expect(assigns[:pagy].page).to eq(1)
      expect(assigns[:pagy].items).to eq(15)
    end
  end

  describe '#index' do
    context 'without stock location' do
      it 'returns 200' do
        get :index

        expect(response.status).to be(200)
      end
    end

    context 'with stock location' do
      it 'returns 200' do
        get :index, params: { stock_location_id: stock_location.id }

        expect(response.status).to be(200)
      end
    end
  end
end
