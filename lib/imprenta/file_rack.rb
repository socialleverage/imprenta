module Imprenta
  class FileRack
    attr_accessor :custom_domain

    def initialize(args = {})
      @custom_domain = args[:custom_domain]
    end

    def call(env)
      request = ::Rack::Request.new(env)
      path = custom_domain ? env["SERVER_NAME"] : id_from_env(env)

      raise ::ActionController::RoutingError.exception("Page Not Found") unless path

      file, headers = pick_file_and_headers_for_path(path, request)
      env.merge!("PATH_INFO" => "/")
      ::Rack::File.new(file, headers).call(env)
    end

    private

    def id_from_env(env)
      env["action_dispatch.request.path_parameters"][:id]
    end

    def get_best_encoding(request)
      ::Rack::Utils.select_best_encoding(%w(gzip identity), request.accept_encoding)
    end

    def headers
      @headers ||= {'Content-Type' => 'text/html' }
    end

    def pick_file_and_headers_for_path(path, request)
      encoding = get_best_encoding(request)
      file = "#{Rails.public_path}/imprenta/" + path + '.html'
      if File.exist?(file)
        if encoding == 'gzip'
          file = file + '.gz'
          headers['Content-Encoding'] = 'gzip'
        end
      else
        raise ::ActionController::RoutingError.exception("Page Not Found")
      end
      [file, headers]
    end
  end
end
