Rails.application.routes.draw do
  root to: 'static_pages#startpage'
  get 'go', to: 'static_pages#root'
  
  get 'sessions/demo', to: 'sessions#demo'
  
  resources :users, only: [:new, :create]
  
  resource :session, only: [:new, :create, :destroy]
  
  namespace :api do
    resources :projects, except: [:new, :edit] do
      resources :tabs, except: [:new, :edit]
      resources :stories, except: [:new, :edit]
    end
  end
end
