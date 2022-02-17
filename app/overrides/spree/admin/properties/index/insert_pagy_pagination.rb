# frozen_string_literal: true

Deface::Override.new(
  name: 'properties/index/insert_pagy_pagination#list',
  original: 'c2d3b41787ed2e7a731868e9a222898b1e62dfa9',
  virtual_path: 'spree/admin/properties/index',
  replace: 'erb[loud]:contains("paginate @collection")',
  text: '<%== pagy_nav(@pagy, pagy_id: "properties_pagination") if @pagy.pages > 1 %>'
)
