Rails.application.routes.draw do
  resources :users do
    resources :friendships, except: [:new, :show, :edit]
    resources :matches, only:[:update]
  end
  resources :pairings, only:[:create, :show, :destroy, :update, :new]
  resources :rejected_pairings, only: [:create]
  get 'confirmed', to: 'pairings#confirmed'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/invite' => 'users#invite'

  root 'users#index'

  resources :messages, only: [:new, :create]

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
    end
  end
end
