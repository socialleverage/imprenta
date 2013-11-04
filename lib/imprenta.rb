require "imprenta/version"
require "rails"
require "imprenta/configuration"
require "imprenta/file_rack"
require "imprenta/cache_page"
require "imprenta/static_server"
require "imprenta/storage/file"
require "imprenta/rails"

module Imprenta
  class << self

    def server
      Imprenta::StaticServer.new
    end

    def configuration
      @configuration ||= Imprenta::Configuration.new
    end

    def configure(&block)
      configuration.configure(&block)
    end
  end
end
