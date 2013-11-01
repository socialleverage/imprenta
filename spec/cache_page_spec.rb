require 'spec_helper'

class DummyController
  include Imprenta::CachePage
end

describe "Cache Page Module" do
  let(:controller)  { DummyController.new}

  after do
    FileUtils.rm_rf(File.join([File.dirname(__FILE__), "../", "dummy", "public", "imprenta"]))
  end

  context "#imprenta_cache_page" do
    let(:path) { Rails.public_path.to_s + '/imprenta/test.html' }

    it "creates html and html.gz files for the cached content" do
      controller.imprenta_cache_page("test", "test")
      expect(File.exist?(path)).to be_true
      expect(File.exist?(path + '.gz')).to be_true
    end

    it "creates file with the content provided" do
      controller.imprenta_cache_page("test", "test")
      file = File.open(path, 'r')
      expect(file.read).to eq("test")
    end
  end
end
