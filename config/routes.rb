Rails.application.routes.draw do
  resources :execs

  resources :feedbacks

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :cases

  devise_for :delegates

  root to: 'info#home'
end
