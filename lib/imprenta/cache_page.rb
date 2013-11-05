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
      @storage ||= case Imprenta.configuration.storage
                     when :file then Imprenta::Storage::File.new
                     when :s3 then Imprenta::Storage::S3.new
                     else raise StandardError.exception("Invalid storage provider")
                   end
    end
  end
end
