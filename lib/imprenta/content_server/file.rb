module Imprenta
  module ContentServer
    class File
      def generate_response(path, env)
        request = ::Rack::Request.new(env)
        file, headers = pick_file_and_headers_for_path(path, request)
        env.merge!("PATH_INFO" => "/")
        ::Rack::File.new(file, headers).call(env)
      end

      private

      def headers
        @headers ||= {'Content-Type' => 'text/html' }
      end

      def pick_file_and_headers_for_path(path, request)
        encoding = get_best_encoding(request)
        file = "#{Rails.public_path}/imprenta/" + path + '.html'
        if ::File.exist?(file)
          if encoding == 'gzip'
            file = file + '.gz'
            headers['Content-Encoding'] = 'gzip'
          end
        else
          raise ::ActionController::RoutingError.exception("Page Not Found")
        end
        [file, headers]
      end

      def get_best_encoding(request)
        ::Rack::Utils.select_best_encoding(%w(gzip identity), request.accept_encoding)
      end
    end
  end
end
