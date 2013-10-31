class Engine < Rails::Engine
  initializer 'imprenta.controller_methods' do |app|
    ActionController::Base.send :include, Imprenta::CachePage
  end
end
