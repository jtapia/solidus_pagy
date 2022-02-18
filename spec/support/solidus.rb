# frozen_string_literal: true

require 'spree/testing_support/flash'
require 'spree/testing_support/url_helpers'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/translations'
require 'spree/testing_support/order_walkthrough'

RSpec.configure do |config|
  config.include Spree::TestingSupport::Flash
  config.include Spree::TestingSupport::UrlHelpers
  config.include Spree::TestingSupport::ControllerRequests, type: :controller
  config.include Spree::TestingSupport::Translations
  config.include Rails.application.routes.url_helpers
end
