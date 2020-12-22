Rails.application.routes.draw do
  resources :routes, only: [:index] do 
    collection do
      get :assigned
    end
  end
  resources :vehicles, only: [:index]
  resources :drivers, only: [:index]

  root  :to => 'routes#assigned'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
