require 'spec_helper'

describe "Imprenta configuraion" do
  before do
    Imprenta.configuration.reset
  end

  context "defaults"  do
    it "custom_domain is set to false" do
      expect(Imprenta.configuration.custom_domain).to be_false
    end

    it "storage is set to false" do
      expect(Imprenta.configuration.storage).to eq(:file)
    end

    it "development is set to false" do
      expect(Imprenta.configuration.development).to be_false
    end

    it "middlewares is initialized to a middleware stack" do
      expect(Imprenta.configuration.middlewares).to be_kind_of(ActionDispatch::MiddlewareStack)
    end
  end

  context "when configuring" do
    context "fog" do
      it "sets aws_secret_access_key  " do
        Imprenta.configure do |config|
          config.aws_secret_access_key = "xxxsecret"
        end
        expect(Imprenta.configuration.aws_secret_access_key).to eq("xxxsecret")
      end

      it "aws_access_key_id" do
        Imprenta.configure do |config|
          config.aws_access_key_id = "xxxkeyid"
        end
        expect(Imprenta.configuration.aws_access_key_id).to eq("xxxkeyid")
      end
    end

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
