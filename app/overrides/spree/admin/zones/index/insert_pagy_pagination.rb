# frozen_string_literal: true

Deface::Override.new(
  name: 'zones/index/insert_pagy_pagination#list',
  original: '52486164557b59e1bc70c5a486ffd63584294d84',
  virtual_path: 'spree/admin/zones/index',
  replace: 'erb[loud]:contains("paginate @zones")',
  text: '<%== send(SolidusPagy.config.nav_helper.to_sym, @pagy, pagy_id: "zones_pagination") if @pagy.pages > 1 %>'
)
