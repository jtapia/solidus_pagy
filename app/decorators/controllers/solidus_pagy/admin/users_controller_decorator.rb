# frozen_string_literal: true

module SolidusPagy
  module Admin
    module UsersControllerDecorator
      def self.prepended(base)
        base.class_eval do
          def orders
            params[:q] ||= {}

            @search = ::Spree::Order.reverse_chronological.ransack(
              params[:q].merge(user_id_eq: @user.id)
            )

            @result = pagy(
              @search.result,
              page: params[:page],
              items: ::SolidusPagy.config.admin_products_per_page
            )

            @pagy = @result.first
            @orders = @result.second
          end

          def items
            params[:q] ||= {}

            @search = Spree::Order.includes(
              line_items: {
                variant: [:product, { option_values: :option_type }]
              }
            ).ransack(params[:q].merge(user_id_eq: @user.id))

            @result = pagy(
              @search.result,
              page: params[:page],
              items: ::SolidusPagy.config.admin_products_per_page
            )

            @pagy = @result.first
            @orders = @result.second
          end

          private

          def collection
            return @collection if @collection

            @search = super.ransack(params[:q])
            @collection = @search.result.includes(:spree_roles)
            @collection = @collection.includes(:spree_orders)

            @result = pagy(
              @collection,
              page: params[:page],
              items: params[:per_page]
            )

            @pagy = @result.first
            @users = @result.second
          end
        end
      end

      ::Spree::Admin::UsersController.prepend(self)
    end
  end
end
