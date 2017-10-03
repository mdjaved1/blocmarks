Rails.application.routes.draw do

  devise_for :users

  resources :topics do
    resources :bookmarks
  end

  resources :bookmarks, except: [:index] do
    resources :likes, only: [:create, :destroy]
  end

  resources :users, only: [:new, :index, :show]


  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'

end