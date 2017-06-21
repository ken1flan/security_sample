Rails.application.routes.draw do
  get 'top/show'

  resource :session, only: [:new, :create, :destroy]
  get '/blogs/create', to: 'blogs#create', as: 'create_blog'
  resources :blogs
  resources :users
  resource :measurement_tag
  resource :redirector, only: [:show]

  root controller: 'top', action: 'show'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
