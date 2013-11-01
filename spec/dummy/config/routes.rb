Rails.application.routes.draw do
  get 'imprenta/:id', :to => Imprenta.server
  get '/imprenta', :to => "index#home"
  post 'publish', :to => "publish#home"
end
