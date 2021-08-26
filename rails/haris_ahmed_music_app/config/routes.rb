Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :show]

  resource :session 

  resources :bands do
    resources :albums, only: [:index]
  end

  resources :albums, only: [:show, :update, :create, :destroy]

end
