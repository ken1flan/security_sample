Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :blogs
  resources :users
  root controller: 'blogs', action: 'index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
