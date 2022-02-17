# frozen_string_literal: true

module SolidusPagy
  module Admin
    module StockItemsControllerDecorator
      def self.prepended(base)
        base.class_eval do
          private

          def load_stock_management_data
            @stock_locations = ::Spree::StockLocation.accessible_by(current_ability)
            @stock_item_stock_locations = if params[:stock_location_id].present?
                                            @stock_locations.where(id: params[:stock_location_id])
                                          else
                                            @stock_locations
                                          end
            @variant_display_attributes = self.class.variant_display_attributes
            @variants = ::Spree::Config.variant_search_class.new(
              params[:variant_search_term], scope: variant_scope
            ).results
            @variants = @variants.includes(
              :images,
              stock_items: :stock_location,
              product: :variant_images
            )
            @variants = @variants.includes(option_values: :option_type)

            @result = pagy(
              @variants.order(id: :desc),
              page: params[:page],
              items: params[:per_page] || ::SolidusPagy.config.orders_per_page
            )
            @pagy = @result.first
            @variants = @result.second
          end
        end
      end

      ::Spree::Admin::StockItemsController.prepend(self)
    end
  end
end
