# frozen_string_literal: true

Deface::Override.new(
  name: 'tax_rates/index/insert_pagy_pagination#list',
  original: '0b28a26d9e429d793c31354061e6e795dafa8139',
  virtual_path: 'spree/admin/tax_rates/index',
  replace: 'erb[loud]:contains("paginate @tax_rates")',
  text: '<%== pagy_nav(@pagy, pagy_id: "tax_rates_pagination") if @pagy.pages > 1 %>'
)
