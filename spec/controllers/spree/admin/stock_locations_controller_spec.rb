# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::StockLocationsController, type: :controller do
  stub_authorization!

  let!(:stock_location) { create(:stock_location) }

  context 'with pagination' do
    it 'can page through the promotions' do
      get :index, params: { page: 1 }
      expect(assigns[:pagy].page).to eq(1)
      expect(assigns[:pagy].items).to eq(10)
    end
  end

  describe '#index' do
    it 'returns 200' do
      get :index

      expect(assigns[:collection]).not_to be_empty
      expect(assigns[:collection]).to include(stock_location)
    end
  end
end
