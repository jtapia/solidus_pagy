# frozen_string_literal: true

module SolidusPagy
  module Admin
    module StockLocationsControllerDecorator
      def self.prepended(base)
        base.class_eval do
          private

          def collection
            @result = pagy(
              super,
              page: params[:page],
              items: ::SolidusPagy.config.admin_products_per_page
            )
            @pagy = @result.first
            @collection = @result.second
          end
        end
      end

      ::Spree::Admin::StockLocationsController.prepend(self)
    end
  end
end
