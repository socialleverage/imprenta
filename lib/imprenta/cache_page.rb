module Imprenta
  module CachePage
    # This methods come from action_pack/cache_page'
    # https://github.com/rails/actionpack-page_caching
    # We didn't need the whole gem. So I decided to get
    # just what we need :)

    attr_accessor :storage

    def initialize
      @storage = Imprenta::Storage::File.new
    end

    def imprenta_cache_template(args = {})
      template = args.fetch(:template)
      layout = args.fetch(:layout) { 'application'}
      id = args.fetch(:id)

      content = render_to_string(template: template, layout: layout)
      imprenta_cache_page(content, id)
    end

    def imprenta_cache_page(content, id)
      storage.persist(content, id)
    end
  end
end
