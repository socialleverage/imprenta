module Imprenta
  module Storage
    class File
      # This methods come from action_pack/cache_page'
      # https://github.com/rails/actionpack-page_caching
      # We didn't need the whole gem. So I decided to get
      # just what we need :)
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
