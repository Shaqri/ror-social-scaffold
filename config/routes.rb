Rails.application.routes.draw do

  get 'friendships/index'
  get 'friendships/create'
  get 'friendships/destroy'
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create, :index, :destroy, :update]
    delete '/friendships/cancelrequest/:id', to: 'friendships#cancel_request', as: 'cancel_request'
    delete '/friendships/deletefriend/:id', to: 'friendships#delete_friend', as: 'delete_friend'
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
