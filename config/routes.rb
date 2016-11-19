Rails.application.routes.draw do
  resources :servers, only: [:index, :show, :create]
  resources :maxscale_services, only: [:index, :show], path: 'services'
  resources :maxscale_listeners, only: [:index], path: 'listeners'
end
