Admin::Engine.routes.draw do
  root to: 'top#index'

  resource :session, only: [:new, :create, :destroy]
  resources :redirection_logs, only: [:index]
end
