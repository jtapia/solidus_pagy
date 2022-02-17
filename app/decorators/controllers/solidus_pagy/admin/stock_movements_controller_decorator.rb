# frozen_string_literal: true

module SolidusPagy
  module Admin
    module StockMovementsControllerDecorator
      def self.prepended(base)
        base.class_eval do
          def index
            params[:q] ||= {}

            @search = collection.ransack(params[:q])
            @result = pagy(
              @search.result,
              page: params[:page]
            )
            @pagy = @result.first
            @stock_movements = @result.second
          end
        end
      end

      ::Spree::Admin::StockMovementsController.prepend(self)
    end
  end
end
