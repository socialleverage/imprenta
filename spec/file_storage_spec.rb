require 'spec_helper'

describe Imprenta::Storage::File do
  let(:storage)  { described_class.new}

  after do
    FileUtils.rm_rf(File.join([File.dirname(__FILE__), "../", "dummy", "public", "imprenta"]))
  end

  context "#persist" do
    let(:path) { Rails.public_path.to_s + '/imprenta/test.html' }

    it "creates html and html.gz files for the cached content" do
      storage.persist("test", "test")
      expect(File.exist?(path)).to be_true
      expect(File.exist?(path + '.gz')).to be_true
    end

    it "creates file with the content provided" do
      storage.persist("test", "test")
      file = File.open(path, 'r')
      expect(file.read).to eq("test")
    end
  end
end
