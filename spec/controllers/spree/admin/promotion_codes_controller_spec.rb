# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::PromotionCodesController, type: :controller do
  stub_authorization!

  let(:promotion) { create(:promotion) }
  let(:code1) { create(:promotion_code, promotion: promotion) }
  let(:code2) { create(:promotion_code, promotion: promotion) }
  let(:code3) { create(:promotion_code, promotion: promotion) }

  context 'with pagination' do
    it 'can page through the products' do
      get :index,
        params: {
          promotion_id: promotion.id,
          page: 1
        }
      expect(assigns[:pagy].page).to eq(1)
      expect(assigns[:pagy].items).to eq(50)
    end
  end
end
