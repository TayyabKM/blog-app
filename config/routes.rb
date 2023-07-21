Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    member do
      get 'posts', to: 'users#posts'
    end
    resources :posts, only: :show, controller: 'posts'
  end

  resources :posts, only: [:index, :show]
end
