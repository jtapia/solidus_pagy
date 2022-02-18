# frozen_string_literal: true

Deface::Override.new(
  name: 'prices/table/insert_pagy_pagination#list',
  original: '1200edf2531c8fa4f48a65f17788b77b6f414d73',
  virtual_path: 'spree/admin/prices/_table',
  replace: 'erb[loud]:contains("paginate variant_prices")',
  text: '<%== send(SolidusPagy.config.nav_helper.to_sym,
                   @pagy_variant_prices,
                   pagy_id: "variant_prices_pagination") if @pagy_variant_prices.pages > 1 %>'
)
