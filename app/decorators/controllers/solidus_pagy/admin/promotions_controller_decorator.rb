# frozen_string_literal: true

module SolidusPagy
  module Admin
    module PromotionsControllerDecorator
      def self.prepended(base)
        base.class_eval do
          private

          def collection
            return @collection if @collection

            params[:q] ||= HashWithIndifferentAccess.new
            params[:q][:s] ||= 'id desc'

            @collection = super
            @search = @collection.ransack(params[:q])
            @result = pagy(
              @search.result(distinct: true).includes(promotion_includes),
              page: params[:page],
              items: params[:per_page] || ::SolidusPagy.config.promotions_per_page
            )
            @pagy = @result.first
            @collection = @result.second
          end
        end
      end

      ::Spree::Admin::PromotionsController.prepend(self)
    end
  end
end
