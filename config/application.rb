require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HelloRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Enable the asset pipeline
    config.assets.enabled = true
    # compress assets
    config.assets.css_compressor = :sass

    # Precompile additional assets
    config.assets.precompile += %w( additional_asset.js additional_asset.css )

    # Add additional assets paths
    # config.assets.paths << Rails.root.join('vendor', 'assets')


  end
end
