Rails.application.routes.draw do
  resources :execs

  resources :feedbacks

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :cases

  devise_for :delegates


  get '/team', to: 'execs#index'

  # IF user session exists
  authenticated :delegate do
    root to: 'delegate_actions#portal', as: "authenticated_root"
  end
    root to: 'info#home'

end
