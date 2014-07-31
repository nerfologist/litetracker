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
  end
end