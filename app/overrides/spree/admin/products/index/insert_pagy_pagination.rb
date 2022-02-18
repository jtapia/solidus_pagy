# frozen_string_literal: true

Deface::Override.new(
  name: 'products/index/insert_pagy_pagination#list',
  original: 'c2d3b41787ed2e7a731868e9a222898b1e62dfa9',
  virtual_path: 'spree/admin/products/index',
  replace: 'erb[loud]:contains("paginate @collection")',
  text: '<%== send(SolidusPagy.config.nav_helper.to_sym, @pagy, pagy_id: "products_pagination") if @pagy.pages > 1 %>'
)
