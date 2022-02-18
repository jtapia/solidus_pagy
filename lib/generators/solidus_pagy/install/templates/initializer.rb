# frozen_string_literal: true

#  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Option     | Helper               | Path                     |
#  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | default    | pagy_nav             |                          |
# | bootstrap  | pagy_bootstrap_nav   | pagy/extras/bootstrap    |
# | bulma      | pagy_bulma_nav       | pagy/extras/bulma        |
# | foundation | pagy_foundation_nav  | pagy/extras/foundation   |
# | materialize| pagy_materialize_nav | pagy/extras/materialize  |
# | semantic   | pagy_semantic_nav    | pagy/extras/semantic     |
# | uikit      | pagy_uikit_nav       | pagy/extras/uikit        |
#  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

SolidusPagy.configure do |config|
  config.nav_helper = 'pagy_nav'
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
