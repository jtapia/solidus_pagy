# frozen_string_literal: true

Deface::Override.new(
  name: 'prices/master_variant_table/insert_pagy_pagination#list',
  original: '5280d1ae82211875dfa421b8a28a69011ffbb928',
  virtual_path: 'spree/admin/prices/_master_variant_table',
  replace: 'erb[loud]:contains("paginate master_prices")',
  text: '<%== send(SolidusPagy.config.nav_helper.to_sym,
                   @pagy_master_prices,
                   pagy_id: "master_prices_pagination") if @pagy_master_prices.pages > 1 %>'
)
