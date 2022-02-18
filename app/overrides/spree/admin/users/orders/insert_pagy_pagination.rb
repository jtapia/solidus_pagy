# frozen_string_literal: true

Deface::Override.new(
  name: 'users/orders/insert_pagy_pagination#list',
  original: 'b7e52f69693d41381ad087c82d1d90e6bd700e30',
  virtual_path: 'spree/admin/users/orders',
  replace: 'erb[loud]:contains("paginate @orders")',
  text: '<%== send(SolidusPagy.config.nav_helper.to_sym, @pagy, pagy_id: "users_pagination") if @pagy.pages > 1 %>'
)
