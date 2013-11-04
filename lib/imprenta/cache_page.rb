module Imprenta
  module CachePage

    def imprenta_cache_template(args = {})
      template = args.fetch(:template)
      layout = args.fetch(:layout) { 'application'}
      id = args.fetch(:id)

      content = render_to_string(template: template, layout: layout)
      storage.persist(content, id)
    end

    private

    def storage
      @storage ||= Imprenta::Storage::File.new
    end
  end
end
