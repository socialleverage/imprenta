module Imprenta
  module Storage
    class File
      def persist(content, id, extension = '.html', gzip = Zlib::BEST_COMPRESSION)
        path = path_for_id(id, extension)
        FileUtils.makedirs(::File.dirname(path))
        ::File.open(path, 'wb+') { |f| f.write(content) }
        if gzip
          Zlib::GzipWriter.open(path + '.gz', gzip) { |f| f.write(content) }
        end
      end

      private

      def path_for_id(id, extension = nil)
        page_cache_directory = Rails.public_path
        page_cache_directory.to_s + '/imprenta/' + id + extension
      end
    end
  end
end
