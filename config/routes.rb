Rails.application.routes.draw do
  get 'maxscale_monitors/index'

  get 'maxscale_monitors/show'
  resources :maxscale_monitors, only: [:index, :show], path: 'monitors'
  resources :servers, only: [:index, :show, :create, :destroy, :update]
  resources :maxscale_services, only: [:index, :show], path: 'services'
  resources :maxscale_listeners, only: [:index], path: 'listeners'
end
