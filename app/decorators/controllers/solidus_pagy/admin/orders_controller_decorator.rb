# frozen_string_literal: true

module SolidusPagy
  module Admin
    module OrdersControllerDecorator
      def self.prepended(base)
        base.class_eval do
          def index
            params[:q] ||= {}
            params[:q][:completed_at_not_null] ||= '1' if ::Spree::Config[:show_only_complete_orders_by_default]
            @show_only_completed = params[:q][:completed_at_not_null] == '1'
            params[:q][:s] ||= @show_only_completed ? 'completed_at desc' : 'created_at desc'
            params[:q][:completed_at_not_null] = '' unless @show_only_completed

            # As date params are deleted if @show_only_completed, store
            # the original date so we can restore them into the params
            # after the search
            created_at_gt = params[:q][:created_at_gt]
            created_at_lt = params[:q][:created_at_lt]

            params[:q].delete(:inventory_units_shipment_id_null) if params[:q][:inventory_units_shipment_id_null] == "0"

            if params[:q][:created_at_gt].present?
              params[:q][:created_at_gt] = begin
                Time.zone.parse(params[:q][:created_at_gt]).beginning_of_day
              rescue StandardError
                ''
              end
            end

            if params[:q][:created_at_lt].present?
              params[:q][:created_at_lt] = begin
                Time.zone.parse(params[:q][:created_at_lt]).end_of_day
              rescue StandardError
                ''
              end
            end

            if @show_only_completed
              params[:q][:completed_at_gt] = params[:q].delete(:created_at_gt)
              params[:q][:completed_at_lt] = params[:q].delete(:created_at_lt)
            end

            @search = ::Spree::Order.accessible_by(current_ability, :index).ransack(params[:q])
            @result = pagy(
              @search.result.includes([:user]),
              page: params[:page],
              items: params[:per_page] || ::SolidusPagy.config.orders_per_page
            )
            @pagy = @result.first
            @orders = @result.second

            # Restore dates
            params[:q][:created_at_gt] = created_at_gt
            params[:q][:created_at_lt] = created_at_lt
          end
        end
      end

      ::Spree::Admin::OrdersController.prepend(self)
    end
  end
end
