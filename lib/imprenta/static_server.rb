module Imprenta
  class StaticServer
    def initialize(args = {})
      @middleware_stack = args.fetch(:middlewares)
    end

    def call(env)
      @app = build_app
      @app.call(env)
    end

    private

    def build_app
      @app ||= @middleware_stack.build(Imprenta::FileRack.new)
    end

  end
end
