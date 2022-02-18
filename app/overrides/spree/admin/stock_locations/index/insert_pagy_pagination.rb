# frozen_string_literal: true

Deface::Override.new(
  name: 'stock_locations/index/insert_pagy_pagination#list',
  original: '70e191acf75f034d4e2348e8c88b15137de17a1e',
  virtual_path: 'spree/admin/stock_locations/index',
  replace: 'erb[loud]:contains("paginate @stock_locations")',
  text: '<%== send(SolidusPagy.config.nav_helper.to_sym,
                   @pagy,
                   pagy_id: "stock_locations_pagination") if @pagy.pages > 1 %>'
)
