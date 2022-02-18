# frozen_string_literal: true

require 'spec_helper'

describe SolidusPagy::Configuration do
  before do
    SolidusPagy.configure do |config|
      config.page = 1
      config.items = 20
      config.outset = 0
      config.orders_per_page = 15
      config.properties_per_page = 15
      config.promotions_per_page = 15
      config.admin_products_per_page = 10
      config.admin_variants_per_page = 20
    end
  end

  it 'read page value' do
    expect(SolidusPagy.config.page).to be(1)
  end

  it 'read items value' do
    expect(SolidusPagy.config.items).to be(20)
  end

  it 'read outset value' do
    expect(SolidusPagy.config.outset).to be(0)
  end

  it 'read orders_per_page value' do
    expect(SolidusPagy.config.orders_per_page).to be(15)
  end

  it 'read properties_per_page value' do
    expect(SolidusPagy.config.properties_per_page).to be(15)
  end

  it 'read promotions_per_page value' do
    expect(SolidusPagy.config.promotions_per_page).to be(15)
  end

  it 'read admin_products_per_page value' do
    expect(SolidusPagy.config.admin_products_per_page).to be(10)
  end

  it 'read admin_variants_per_page value' do
    expect(SolidusPagy.config.admin_variants_per_page).to be(20)
  end
end
