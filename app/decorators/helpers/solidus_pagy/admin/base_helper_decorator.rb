# frozen_string_literal: true

module SolidusPagy
  module Admin
    module BaseHelperDecorator
      def self.prepended(base)
        base.include ::Pagy::Frontend
      end

      ::Spree::Admin::BaseHelper.prepend(self)
    end
  end
end
