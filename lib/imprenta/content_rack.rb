module Imprenta
  class ContentRack
    attr_accessor :custom_domain, :content_server

    def initialize
      @custom_domain = Imprenta.configuration.custom_domain
      @content_server = Imprenta::ContentServer::File.new
    end

    def call(env)
      path = custom_domain ? env["SERVER_NAME"] : id_from_env(env)
      raise ::ActionController::RoutingError.exception("Page Not Found") unless path

      content_server.generate_response(path, env)
    end

    private

    def id_from_env(env)
      env["action_dispatch.request.path_parameters"][:id]
    end
  end
end
