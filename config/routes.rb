Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  root 'posts#index'

  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end
end
