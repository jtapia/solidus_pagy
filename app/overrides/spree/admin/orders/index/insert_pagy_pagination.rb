# frozen_string_literal: true

Deface::Override.new(
  name: 'orders/index/insert_pagy_pagination#list',
  original: 'b7e52f69693d41381ad087c82d1d90e6bd700e30',
  virtual_path: 'spree/admin/orders/index',
  replace: 'erb[loud]:contains("paginate @orders")',
  text: '<%== pagy_nav(@pagy, pagy_id: "orders_pagination") if @pagy.pages > 1 %>'
)
