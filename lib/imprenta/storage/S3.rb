module Imprenta
  module Storage
    class S3

      attr_accessor :connection

      def initialize
        @connection = Fog::Storage.new(provider: 'AWS',
                                       aws_access_key_id: Imprenta.configuration.aws_access_key_id,
                                       aws_secret_access_key: Imprenta.configuration.aws_secret_access_key)
      end

      def persist(content, id, extension = '.html', gzip = Zlib::BEST_COMPRESSION)
        file_name = id + extension
        write_body_to_s3(file_name, content)
        if gzip
          str = StringIO.new()
          gz = Zlib::GzipWriter.new(str, gzip)
          gz.write(content)
          gz.close
          write_body_to_s3(file_name + ".gz", str.string, 'gzip')
        end
      end

      def write_body_to_s3(key, body, encoding = nil)
        directory.files.create(key: key,
                               body: body,
                               content_type: 'text/html',
                               content_encoding: encoding,
                               public: true)
      end

      def directory
        @directory ||= connection.directories.create(key: 'imprenta', public: true)
      end
    end
  end
end
