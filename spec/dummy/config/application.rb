require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)
require "imprenta"

module Dummy
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.secret_key_base = 'dummy'
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.assets.enabled = true
    config.assets.version = '1.0'
  end
end
