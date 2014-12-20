require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LiteTracker
  class Application < Rails::Application
    config.assets.initialize_on_precompile = false
    config.assets.paths << "app/assets/templates"

    config.time_zone = "Pacific Time (US & Canada)"
    config.active_record.default_timezone = :local

    config.generators do |g|
      # g.stylesheets false
      g.test_framework :rspec,
        :fixtures => true,
        :view_specs => false,
        :helper_specs => false,
        :routing_specs => false,
        :controller_specs => true,
        :request_specs => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
  end
end
