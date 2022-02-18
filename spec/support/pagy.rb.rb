# frozen_string_literal: true

require 'pagy'

RSpec.configure do |config|
  config.include Pagy::Backend
  config.include Pagy::Frontend
end
