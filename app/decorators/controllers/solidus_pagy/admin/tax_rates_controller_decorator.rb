# frozen_string_literal: true

module SolidusPagy
  module Admin
    module TaxRatesControllerDecorator
      def self.prepended(base)
        base.class_eval do
          private

          def collection
            @search = Spree::TaxRate.ransack(params[:q])
            @collection = @search.result
            @result = pagy(
              @collection.includes(:tax_categories).order(:zone_id),
              page: params[:page],
              items: ::SolidusPagy.config.admin_products_per_page
            )
            @pagy = @result.first
            @collection = @result.second
          end
        end
      end

      ::Spree::Admin::TaxRatesController.prepend(self)
    end
  end
end
