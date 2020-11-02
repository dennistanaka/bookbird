Rails.application.routes.draw do
  
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
    get :favorites, on: :member
    resource :relationships, only: [:create, :destroy] do
      post :accept, on: :member
    end
    get :following, on: :member
    get :followers, on: :member
    get :requests, on: :member
  end
  resources :posts, except: :new do
    resource :favorites, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
  end

  get '/about' => 'pages#about', as: 'about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  authenticated :user do
  	root 'posts#index'
  end

  root 'pages#main'
end
