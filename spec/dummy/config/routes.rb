Rails.application.routes.draw do
  get 'imprenta/:id', :to => Imprenta.server
  get '/imprenta', :to => "home#index"
  get 'publish', :to => "home#publish"
end
