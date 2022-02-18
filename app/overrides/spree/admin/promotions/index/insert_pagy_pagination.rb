# frozen_string_literal: true

Deface::Override.new(
  name: 'promotions/index/insert_pagy_pagination#list',
  original: 'e0314f1ec7a40d21ce037d74b77acf6c78faaf43',
  virtual_path: 'spree/admin/promotions/index',
  replace: 'erb[loud]:contains("paginate @promotions")',
  text: '<%== send(SolidusPagy.config.nav_helper.to_sym, @pagy, pagy_id: "promotions_pagination") if @pagy.pages > 1 %>'
)
