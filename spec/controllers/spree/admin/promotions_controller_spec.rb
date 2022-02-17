# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::PromotionsController, type: :controller do
  stub_authorization!

  let!(:promotion1) do
    create(
      :promotion,
      :with_action,
      name: 'name1',
      code: 'code1',
      path: 'path1'
    )
  end
  let!(:promotion2) do
    create(
      :promotion,
      :with_action,
      name: 'name2',
      code: 'code2',
      path: 'path2'
    )
  end
  let!(:promotion3) do
    create(
      :promotion,
      :with_action,
      name: 'name2',
      code: 'code3',
      path: 'path3',
      expires_at: Date.yesterday
    )
  end
  let!(:category) { create :promotion_category }

  context 'pagination' do
    it 'can page through the promotions' do
      get :index, params: { page: 1, per_page: 10 }
      expect(assigns[:pagy].page).to eq(1)
      expect(assigns[:pagy].items).to eq(10)
    end
  end

  describe '#index' do
    it 'succeeds' do
      get :index
      expect(assigns[:promotions])
        .to match_array [promotion3, promotion2, promotion1]
    end

    it 'assigns promotion categories' do
      get :index
      expect(assigns[:promotion_categories]).to match_array [category]
    end

    context 'search' do
      it 'pages results' do
        get :index, params: { per_page: '1' }
        expect(assigns[:promotions]).to eq [promotion3]
      end

      it 'filters by name' do
        get :index, params: { q: { name_cont: promotion1.name } }
        expect(assigns[:promotions]).to eq [promotion1]
      end

      it 'filters by code' do
        get :index,
          params: {
            q: {
              codes_value_cont: promotion1.codes.first.value
            }
          }
        expect(assigns[:promotions]).to eq [promotion1]
      end

      it 'filters by path' do
        get :index, params: { q: { path_cont: promotion1.path } }
        expect(assigns[:promotions]).to eq [promotion1]
      end

      it 'filters by active' do
        get :index, params: { q: { active: true } }
        expect(assigns[:promotions]).to match_array [promotion2, promotion1]
      end
    end
  end
end
