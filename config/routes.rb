Rails.application.routes.draw do
  devise_for :users
  root to:"homes#top"
  get 'home/about' => 'homes#about', as: 'about'
  resources :users, only:[:index,:show,:edit,:update]
  resources :books do
    resource :favorites, only:[:create,:destroy]
  end
end
