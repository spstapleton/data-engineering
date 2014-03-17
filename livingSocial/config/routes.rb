LivingSocial::Application.routes.draw do

  root 'home#index'
  get '/home' => 'home#index'

  #Auth routes
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  resources :sessions, only: [:create, :destroy]


  #Using resources is overkill in this example app as mostly only index is used for each but in for 'upgrade' potential
  resources :merchants, only: [:index]
  resources :orders, only: [:index, :create, :new, :show]
  resources :customers, only: [:index]
  resources :items, only: [:index]

end
