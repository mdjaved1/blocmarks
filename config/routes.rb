Rails.application.routes.draw do
 
  resources :topics do
    resources :bookmarks, except: [:index]
  end

  devise_for :users
  get 'welcome/index'
  get 'welcome/about'
  
  
  root 'welcome#index'
end
