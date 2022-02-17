# frozen_string_literal: true

module SolidusPagy
  module Admin
    module PromotionCodesControllerDecorator
      def self.prepended(base)
        base.class_eval do
          def index
            @promotion = ::Spree::Promotion.accessible_by(current_ability, :show)
                                           .find(params[:promotion_id])
            @promotion_codes = @promotion.promotion_codes.order(:value)

            respond_to do |format|
              format.html do
                @result = pagy(
                  @promotion_codes,
                  page: params[:page],
                  items: 50
                )
                @pagy = @result.first
                @promotion_codes = @result.second
              end

              format.csv do
                filename = "promotion-code-list-#{@promotion.id}.csv"
                headers["Content-Type"] = "text/csv"
                headers["Content-disposition"] = "attachment; filename=\"#{filename}\""
              end
            end
          end
        end
      end

      ::Spree::Admin::PromotionCodesController.prepend(self)
    end
  end
end
