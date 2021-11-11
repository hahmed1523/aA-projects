Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect('/subs')
  
  resources :users 
  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: [:destroy]
  resources :posts do 
    resources :comments, only: [:new]
    member do 
      post 'downvote'
      post 'upvote'
    end
  end

  resources :comments, only: [:create, :show] do 
    member do 
      post 'downvote'
      post 'upvote'
    end
  end

end
