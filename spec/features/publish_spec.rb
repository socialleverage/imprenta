require 'spec_helper'

describe "Visiting a published page" do
  after do
    FileUtils.rm_rf(File.join([File.dirname(__FILE__), "../", "dummy", "public", "imprenta"]))
  end

  context "the user visits a page that is published" do
    it "generates the html and html.gz of the template" do
      # this will publish a page with id testing
      # check spec/dummy/app/controllers to see what's going on.
      visit '/imprenta'
      click_on 'Publish'

      visit '/imprenta/testing'
      expect(page.status_code).to eq(200)
      expect(page).to have_content("dummy")
    end
  end
end
