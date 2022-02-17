# frozen_string_literal: true

Deface::Override.new(
  name: 'variants/_table/insert_pagy_pagination#list',
  original: '0a28fcda35c7d2c7b41b7bc35d0e0fce394cdb6c',
  virtual_path: 'spree/admin/variants/_table',
  replace: 'erb[loud]:contains("paginate variants")',
  text: '<%== pagy_nav(@pagy, pagy_id: "variants_pagination") if @pagy.pages > 1 %>'
)
