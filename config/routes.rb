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

    get '/portal', to: 'delegate_actions#portal'

    get '/all_delegates', to: 'delegate_actions#all_delegates'

    #GBTT: Consistent routing
    get '/case_winners', to: 'cases#winners'

    get '/hosts', to: 'cases#hosts'

    get '/itinerary', to: 'info#itinerary'

    get '/faqs', to: 'info#faq'
end
