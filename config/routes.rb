Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  get '/users/:id/posts', to: 'users#posts', as: 'posts_by_user'
  get '/users/:user_id/posts/:id', to: 'users#post_show', as: 'post_by_user'
end
