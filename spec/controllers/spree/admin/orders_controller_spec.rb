# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::OrdersController, type: :controller do
  let(:store) { create(:store) }

  context 'with authorization' do
    stub_authorization!

    let(:order) do
      mock_model(
        Spree::Order,
        completed?: true,
        total: 100,
        number: 'R123456789',
        all_adjustments: adjustments,
        ship_address: mock_model(Spree::Address)
      )
    end
    let(:adjustments) do
      instance_double('adjustments')
    end

    before do
      request.env['HTTP_REFERER'] = 'http://localhost:3000'
      allow(Spree::Order).to receive_message_chain(:includes, find_by!: order)
      allow(order)
        .to receive_messages(contents: Spree::OrderContents.new(order))
    end

    context 'with pagination' do
      it 'can page through the orders' do
        get :index, params: { page: 1, per_page: 10 }
        expect(assigns[:pagy].page).to eq(1)
        expect(assigns[:pagy].items).to eq(10)
      end
    end

    # Test for https://github.com/spree/spree/issues/3919
    context 'search' do
      let(:user) { create(:user) }

      before do
        allow(controller).to receive(:try_spree_current_user) { user }
        user.spree_roles << Spree::Role.find_or_create_by(name: 'admin')
        create_list(:completed_order_with_totals, 2)
      end

      context 'by line_items_variant_id_in' do
        it 'does not display duplicated results' do
          get :index,
            params: {
              q: {
                line_items_variant_id_in: Spree::Order.first.variants.map(&:id)
              }
            }
          expect(assigns[:orders].size).to eq 1
        end
      end

      context 'by email' do
        it 'does not display duplicated results' do
          get :index,
            params: {
              q: {
                email_start: Spree::Order.first.email
              }
            }
          expect(assigns[:orders].size).to eq 1
          expect(assigns[:orders][0].email).to eq(Spree::Order.first.email)
        end
      end

      context 'by created_at_gt' do
        it 'does display item results' do
          get :index,
            params: {
              q: {
                created_at_gt: DateTime.now - 1.day
              }
            }
          expect(assigns[:orders].size).to eq(2)
        end
      end

      context 'by created_at_lt' do
        it 'does display item results' do
          get :index,
            params: {
              q: {
                created_at_lt: DateTime.now
              }
            }
          expect(assigns[:orders].size).to eq(2)
        end
      end
    end
  end
end
