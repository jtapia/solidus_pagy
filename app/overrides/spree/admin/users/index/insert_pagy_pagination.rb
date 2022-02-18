# frozen_string_literal: true

Deface::Override.new(
  name: 'users/index/insert_pagy_pagination#list',
  original: '9df2b9817425d00013b15e0f58787b2563c2cbff',
  virtual_path: 'spree/admin/users/index',
  replace: 'erb[loud]:contains("paginate @users")',
  text: '<%== send(SolidusPagy.config.nav_helper.to_sym, @pagy, pagy_id: "users_pagination") if @pagy.pages > 1 %>'
)
