# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::PropertiesController, type: :controller do
  stub_authorization!

  context 'pagination' do
    it 'can page through the promotions' do
      get :index, params: { page: 1 }
      expect(assigns[:pagy].page).to eq(1)
      expect(assigns[:pagy].items).to eq(15)
    end
  end
end
