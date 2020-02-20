Rails.application.routes.draw do
  root to: 'comparison#index'
  resources :posts, except: :index
  resources :articles, except: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
end
