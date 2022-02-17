# frozen_string_literal: true

module SolidusPagy
  module Admin
    module VariantsControllerDecorator
      def self.prepended(base)
        base.class_eval do
          private

          def collection
            base_variant_scope ||= super.with_discarded if params[:deleted] == 'on'
            base_variant_scope ||= super

            search = ::Spree::Config.variant_search_class.new(
              params[:variant_search_term], scope: base_variant_scope
            )

            @result = pagy(
              search.results.includes(variant_includes),
              page: params[:page],
              items: ::Spree::Config[:admin_variants_per_page]
            )

            @pagy = @result.first
            @collection = @result.second
          end
        end
      end

      ::Spree::Admin::VariantsController.prepend(self)
    end
  end
end
