Rails.application.routes.draw do
  get 'top/show'

  resource :session, only: [:new, :create, :destroy]
  resources :blogs
  resources :users
  resource :redirector, only: [:show]
  
  root controller: 'top', action: 'show'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
