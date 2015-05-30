Rails.application.routes.draw do
  resources :users do
    resources :friendship, except: [:new, :show, :edit]
    resources :match, only:[:create, :update]
  end
  resources :pairing, only:[:create, :show, :destroy]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  root '/' => 'users/home'
end
