Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  devise_for :users
  root to:"homes#top" 
  resources :books
  resources :users, only:[:index,:show,:edit,:update]
end
