Rails.application.routes.draw do
  resources :routes
  resources :vehicles
  resources :drivers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
