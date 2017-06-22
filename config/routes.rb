Rails.application.routes.draw do
  get 'top/show'

  resource :session, only: [:new, :create, :destroy]
  get '/blogs/create', to: 'blogs#create', as: 'create_blog'
  resources :blogs, only: [:index, :show]
  resources :users do
    resources :blogs, module: :users
  end
  resource :measurement_tag
  resource :redirector, only: [:show]

  root controller: 'top', action: 'show'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
