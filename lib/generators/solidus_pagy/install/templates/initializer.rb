# frozen_string_literal: true

require 'pagy/extras/bootstrap'

SolidusPagy.configure do |config|
  config.page = 1
  config.items = 20
  config.outset = 0
  config.orders_per_page = 15
  config.properties_per_page = 15
  config.promotions_per_page = 15
  config.admin_products_per_page = 10
  config.admin_variants_per_page = 20
end

Pagy::DEFAULT[:page] = SolidusPagy.config.page
Pagy::DEFAULT[:items] = SolidusPagy.config.items
Pagy::DEFAULT[:outset] = SolidusPagy.config.outset
Pagy::DEFAULT.freeze
