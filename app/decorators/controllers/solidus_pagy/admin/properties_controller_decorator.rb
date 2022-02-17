# frozen_string_literal: true

module SolidusPagy
  module Admin
    module PropertiesControllerDecorator
      def self.prepended(base)
        base.class_eval do
          private

          def collection
            return @collection if @collection

            # params[:q] can be blank upon pagination
            params[:q] = {} if params[:q].blank?

            @collection = super
            @search = @collection.ransack(params[:q])
            @result = pagy(
              @search.result,
              page: params[:page],
              items: ::SolidusPagy.config.properties_per_page
            )
            @pagy = @result.first
            @collection = @result.second
          end
        end
      end

      ::Spree::Admin::PropertiesController.prepend(self)
    end
  end
end
