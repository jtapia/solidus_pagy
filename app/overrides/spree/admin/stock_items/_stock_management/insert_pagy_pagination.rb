# frozen_string_literal: true

Deface::Override.new(
  name: 'stock_items/_stock_management/insert_pagy_pagination#list',
  original: 'e47566029b18a9272fd4dd1d1e881754e9af5f79',
  virtual_path: 'spree/admin/stock_items/_stock_management',
  replace: 'erb[loud]:contains("paginate @variants")',
  text: '<%== pagy_nav(@pagy, pagy_id: "stock_items_pagination") if @pagy.pages > 1 %>'
)
