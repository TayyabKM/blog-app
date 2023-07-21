Rails.application.routes.draw do

  root 'users#index'

  resources :users, only: [:index, :show] do
    member do
      get 'posts', to: 'users#posts'
    end
  end

  resources :posts, only: [:index, :show]
end
