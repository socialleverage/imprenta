module Imprenta
  class Configuration
    # Same configuration pattern that sferik uses in:
    # https://github.com/sferik/mtgox/blob/master/lib/mtgox/configuration.rb
    VALID_OPTIONS_KEYS = [:middlewares,
                          :storage,
                          :custom_domain,
                          :aws_access_key_id,
                          :aws_secret_access_key,
                          :aws_bucket,
                          :development]

    attr_accessor *VALID_OPTIONS_KEYS

    def initialize
      reset
      setup_default_middlewares
    end

    def configure
      yield self
    end

    def reset
      self.middlewares = ActionDispatch::MiddlewareStack.new
      self.development = false
      self.storage = :file
      self.custom_domain = false
    end

    def setup_default_middlewares
      self.middlewares.use ActionDispatch::ShowExceptions, show_exception_app
    end

    private

    def development?
      development
    end

    def show_exception_app
      ActionDispatch::PublicExceptions.new(Rails.public_path)
    end
  end
end
