# frozen_string_literal: true

module SolidusPagy
  module Admin
    module BaseControllerDecorator
      def self.prepended(base)
        base.include ::Pagy::Backend
      end

      ::Spree::Admin::BaseController.prepend(self)
    end
  end
end
