module Imprenta
  class StaticServer

    attr_accessor :custom_domain

    def initialize(args = {})
      @middleware_stack = args.fetch(:middlewares)
      @custom_domain = args[:custom_domain]
    end

    def call(env)
      @app = build_app
      @app.call(env)
    end

    private

    def build_app
      @app ||= @middleware_stack.build(Imprenta::FileRack.new(custom_domain: custom_domain))
    end

  end
end
