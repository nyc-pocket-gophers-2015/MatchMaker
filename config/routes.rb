Rails.application.routes.draw do
  resources :users do
    resources :friendships, except: [:new, :show, :edit]
    resources :matches, only:[:create, :update]
  end
  resources :pairings, only:[:create, :show, :destroy]

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
