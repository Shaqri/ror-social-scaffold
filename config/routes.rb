Rails.application.routes.draw do
  
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create, :index, :update]
    delete '/friendships/decline/:id', to: 'friendships#decline_request', as: 'decline_request'
    delete '/friendships/cancel/:id', to: 'friendships#cancel_request', as: 'cancel_request'
    delete '/friendships/delete/:id', to: 'friendships#delete_friend', as: 'delete_friend'
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
