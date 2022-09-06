# frozen_string_literal: true

module SolidusPagy
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_pagy'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
