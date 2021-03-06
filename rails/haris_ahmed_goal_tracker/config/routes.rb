Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect('/users')

  resource :session, only: [:new, :create, :destroy]

  resources :users do 
    resources :goals, only: [:index]
  end

  resources :goals, except: [:index]

  resources :comments, only: [:create]

end
