Rails.application.routes.draw do
  root to: 'static_pages#root'
  
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  
  namespace :api do
    resources :projects, only: [:index, :create, :show, :update, :destroy] do
      resources :tabs, only: [:index, :create, :show, :update, :destroy]
      resources :stories, only: [:index, :create, :show, :update, :destroy]
    end
  end
end
