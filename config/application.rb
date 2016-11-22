require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require_relative "../lib/maxadmin/command.rb"
require_relative "../lib/maxadmin/list_loader.rb"
require_relative "../lib/maxadmin/show_loader.rb"
require_relative "../lib/maxadmin/show_parser.rb"
require_relative "../lib/maxadmin/show_transformer.rb"
require_relative "../lib/maxadmin/monitor_loader.rb"
module Maxjsonapi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.middleware.insert_before(Rack::Runtime, Rack::ReverseProxy) do
      reverse_proxy_options preserve_host: true
      reverse_proxy '/variables', "http://#{ENV['MAXSCALE_MAXINFO_IP_PORT']}/variables"
      reverse_proxy '/status', "http://#{ENV['MAXSCALE_MAXINFO_IP_PORT']}/status"
      reverse_proxy '/modules', "http://#{ENV['MAXSCALE_MAXINFO_IP_PORT']}/modules"
      reverse_proxy '/sessions', "http://#{ENV['MAXSCALE_MAXINFO_IP_PORT']}/sessions"
      reverse_proxy '/event/times', "http://#{ENV['MAXSCALE_MAXINFO_IP_PORT']}/event/times"
      reverse_proxy '/clients', "http://#{ENV['MAXSCALE_MAXINFO_IP_PORT']}/clients"
    end
  end
end
