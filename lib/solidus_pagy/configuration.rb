# frozen_string_literal: true

module SolidusPagy
  class Configuration
    attr_accessor :page,
      :items,
      :outset,
      :promotions_per_page,
      :properties_per_page,
      :orders_per_page,
      :admin_products_per_page,
      :admin_variants_per_page
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    alias config configuration

    def configure
      yield configuration
    end
  end
end
