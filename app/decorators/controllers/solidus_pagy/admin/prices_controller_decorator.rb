# frozen_string_literal: true

module SolidusPagy
  module Admin
    module PricesControllerDecorator
      def self.prepended(base)
        base.class_eval do
          def index
            params[:q] ||= {}

            @search = @product.prices
                              .accessible_by(current_ability, :index)
                              .ransack(params[:q])
            master_prices_search_result(@search)
            variant_prices_search_result(@search)
          end

          private

          def master_prices_search_result(search)
            @result = pagy(
              search.result
                    .currently_valid
                    .for_master
                    .order(:variant_id, :country_iso, :currency),
              page: params[:page],
              items: Spree::Config.admin_variants_per_page
            )
            @pagy_master_prices = @result.first
            @master_prices = @result.second
          end

          def variant_prices_search_result(search)
            @result = pagy(
              search.result
                    .currently_valid
                    .for_variant
                    .order(:variant_id, :country_iso, :currency),
              page: params[:variants_page],
              items: Spree::Config.admin_variants_per_page
            )
            @pagy_variant_prices = @result.first
            @variant_prices = @result.second
          end
        end
      end

      ::Spree::Admin::PricesController.prepend(self)
    end
  end
end
