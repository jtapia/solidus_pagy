# frozen_string_literal: true

Deface::Override.new(
  name: 'promotion_codes/index/insert_pagy_pagination#info',
  original: 'fdef17fe07f87ed1ddfe8ff8ae04a50afbe2b796',
  virtual_path: 'spree/admin/promotion_codes/index',
  replace: 'erb[loud]:contains("page_entries_info(@promotion_codes)")',
  text: '<%== pagy_info(@pagy) %>'
)

Deface::Override.new(
  name: 'promotion_codes/index/insert_pagy_pagination#list',
  original: 'd95e6d826172f503b6d6201eed50298dcf4fd4ec',
  virtual_path: 'spree/admin/promotion_codes/index',
  replace: 'erb[loud]:contains("paginate @promotion_codes")',
  text: '<%== send(SolidusPagy.config.nav_helper.to_sym,
                   @pagy,
                   pagy_id: "promotion_codes_pagination") if @pagy.pages > 1 %>'
)
