require 'open-uri'
module Imprenta
  module ContentServer
    class S3

      attr_accessor :bucket

      def initialize
        @bucket = Imprenta.configuration.aws_bucket
      end

      def generate_response(path, env)
        content = open("https://s3.amazonaws.com/#{bucket}/#{path}.html.gz")
        if success?(content)
          body = content.read
          content.close
          headers = content.meta.slice("etag", "last-modified", "content-type")
          headers['Cache-Control'] = 'max-age=3600'
          [200, headers, [body]]
        else
          raise ::ActionController::RoutingError.exception("Page Not Found")
        end
      end

      private

      def success?(content)
        content.status[0] == "200"
      end
    end
  end
end
