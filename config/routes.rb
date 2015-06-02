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
  post '/invite' => 'users#invite'

  root 'users#home'

  resources :messages, only: [:new, :create]

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
    end
  end

  match 'auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  match 'auth/failure' => redirect('/'), via: [:get, :post]
  match 'signout' => 'sessions#destroy', as: 'signout', via: [:get, :post]
end
