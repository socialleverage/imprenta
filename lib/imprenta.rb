require "imprenta/version"
require "rails"
require "fog"
require "imprenta/configuration"
require "imprenta/storage/file"
require "imprenta/storage/S3"
require "imprenta/cache_page"
require "imprenta/content_server/file"
require "imprenta/content_server/s3"
require "imprenta/content_rack"
require "imprenta/static_server"
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
