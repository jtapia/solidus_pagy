# frozen_string_literal: true

module SolidusPagy
  module Admin
    module ProductsControllerDecorator
      def self.prepended(base)
        base.class_eval do
          private

          def collection
            return @collection if @collection

            params[:q] ||= {}
            params[:q][:s] ||= 'name asc'
            # @search needs to be defined as this is passed to search_form_for
            @search = super.ransack(params[:q])
            @result = pagy(
              @search.result.order(id: :asc)
                            .includes(product_includes),
              page: params[:page],
              items: ::SolidusPagy.config.admin_products_per_page
            )
            @pagy = @result.first
            @collection = @result.second
          end
        end
      end

      ::Spree::Admin::ProductsController.prepend(self)
    end
  end
end
