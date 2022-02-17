# frozen_string_literal: true

module SolidusPagy
  module Admin
    module ZonesControllerDecorator
      def self.prepended(base)
        base.class_eval do
          private

          def collection
            params[:q] ||= {}
            params[:q][:s] ||= 'name asc'
            @search = super.ransack(params[:q])
            @result = pagy(
              @search.result,
              page: params[:page],
              items: params[:per_page]
            )
            @pagy = @result.first
            @zones = @result.second
          end
        end
      end

      ::Spree::Admin::ZonesController.prepend(self)
    end
  end
end
