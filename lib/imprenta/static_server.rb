module Imprenta
  class StaticServer

    def initialize
      @middleware_stack = Imprenta.configuration.middlewares
    end

    def call(env)
      @app = build_app
      @app.call(env)
    end

    private

    def build_app
      @app ||= @middleware_stack.build(Imprenta::ContentRack.new)
    end
  end
end
