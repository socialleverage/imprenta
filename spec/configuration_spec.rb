require 'spec_helper'

describe "Imprenta configuraion" do
  context "defaults"  do
    it "custom_domain is set to false" do
      expect(Imprenta.configuration.custom_domain).to be_false
    end

    it "development is set to false" do
      expect(Imprenta.configuration.development).to be_false
    end

    it "middlewares is initialized to a middleware stack" do
      expect(Imprenta.configuration.middlewares).to be_kind_of(ActionDispatch::MiddlewareStack)
    end
  end

  context "when configuring" do
    it "allows to set custom_domain to true" do
      Imprenta.configure do |config|
        config.custom_domain = true
      end
      expect(Imprenta.configuration.custom_domain).to be_true
    end

    it "allows to add custom racks to the config" do
      Imprenta.configure do |config|
        config.middlewares.use DummyRack
      end
      expect(Imprenta.configuration.middlewares.last).to eq(DummyRack)
    end
  end
end
