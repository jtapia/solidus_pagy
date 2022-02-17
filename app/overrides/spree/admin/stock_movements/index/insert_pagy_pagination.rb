# frozen_string_literal: true

Deface::Override.new(
  name: 'stock_movements/index/insert_pagy_pagination#list',
  original: 'fbfad74a653d52d8167dc2f081a6e98e20efa6c4',
  virtual_path: 'spree/admin/stock_movements/index',
  replace: 'erb[loud]:contains("paginate @stock_movements")',
  text: '<%== pagy_nav(@pagy, pagy_id: "stock_movements_pagination") if @pagy.pages > 1 %>'
)
