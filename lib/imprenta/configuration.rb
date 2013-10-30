module Imprenta
  class Configuration
    # Same configuration pattern that sferik uses in:
    # https://github.com/sferik/mtgox/blob/master/lib/mtgox/configuration.rb
    VALID_OPTIONS_KEYS = [:middlewares]

    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def initialize
      reset
      setup_default_middlewares
    end

    def configure(&block)
      block.call
    end

    def reset
      self.middlewares = ActionDispatch::MiddlewareStack.new
    end

    def setup_default_middlewares
      self.middlewares.use ActionDispatch::ShowExceptions, show_exception_app # unless Rails.env.development?
    end

    private

    def show_exception_app
      ActionDispatch::PublicExceptions.new(Rails.public_path)
    end
  end
end
