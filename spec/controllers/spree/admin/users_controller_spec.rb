# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::UsersController, type: :controller do
  stub_authorization!

  let(:user) { create(:user) }
  let(:state) { create(:state, state_code: 'NY') }
  let(:valid_address_attributes) do
    {
      name: 'Foo Bar',
      city: 'New York',
      country_id: state.country.id,
      state_id: state.id,
      phone: '555-555-5555',
      address1: '123 Fake St.',
      zipcode: '10001',
    }
  end

  context 'with pagination' do
    it 'can page through the promotions' do
      get :index, params: { id: user.id, page: 1 }
      expect(assigns[:pagy].page).to eq(1)
      expect(assigns[:pagy].items).to eq(20)
    end
  end

  describe '#index' do
    stub_authorization! do |_user|
      can :manage, Spree.user_class
    end

    context 'when the user can manage all users' do
      it 'assigns a list of all users as @collection' do
        get :index, params: { id: user.id }
        expect(assigns(:collection)).to eq [user]
      end

      it 'assigns a ransack search for Spree.user_class' do
        get :index, params: { id: user.id }
        expect(assigns[:search]).to be_a Ransack::Search
        expect(assigns[:search].klass).to eq Spree.user_class
      end
    end

    context 'when user cannot manage some users' do
      stub_authorization! do |_user|
        can :manage, Spree.user_class
        cannot :manage, Spree.user_class, email: 'not_accessible_user@example.com'
      end

      it 'assigns a list of accessible users as @collection' do
        create(:user, email: 'not_accessible_user@example.com')

        get :index, params: { id: user.id }
        expect(assigns(:collection)).to eq [user]
      end
    end

    context 'when Spree.user_class does not respond to #accessible_by' do
      it 'assigns a list of all users as @collection' do
        allow(Spree.user_class).to receive(:respond_to?).and_call_original
        allow(Spree.user_class).to receive(:respond_to?)
          .with(:accessible_by).and_return(false)

        get :index, params: { id: user.id }
        expect(assigns(:collection)).to eq [user]
      end
    end
  end

  describe '#orders' do
    stub_authorization! do |_user|
      can :manage, Spree.user_class
    end

    let(:order) { create(:order) }

    before { user.orders << order }

    it 'assigns a list of the users orders' do
      get :orders, params: { id: user.id }
      expect(assigns[:orders].count).to eq(1)
      expect(assigns[:orders].first).to eq(order)
    end

    it 'assigns a ransack search for Spree::Order' do
      get :orders, params: { id: user.id }
      expect(assigns[:search]).to be_a(Ransack::Search)
      expect(assigns[:search].klass).to eq(Spree::Order)
    end
  end

  describe '#items' do
    stub_authorization! do |_user|
      can :manage, Spree.user_class
    end

    let(:order) { create(:order) }

    before { user.orders << order }

    it 'assigns a list of the users orders' do
      get :items, params: { id: user.id }
      expect(assigns[:orders].count).to eq(1)
      expect(assigns[:orders].first).to eq(order)
    end

    it 'assigns a ransack search for Spree::Order' do
      get :items, params: { id: user.id }
      expect(assigns[:search]).to be_a(Ransack::Search)
      expect(assigns[:search].klass).to eq(Spree::Order)
    end
  end
end
