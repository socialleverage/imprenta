class HomeController < ApplicationController

  def index
  end

  def publish
    imprenta_cache_template(template: 'home/dummy', id: 'testing')
  end
end
