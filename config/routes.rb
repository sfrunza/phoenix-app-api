Rails.application.routes.draw do

  devise_for :customers, controllers: { registrations: 'customerregistrations', sessions: 'customersessions' }
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }

  namespace :api do
    namespace :v1 do

      resources :jobs, only: [:index, :show, :create, :edit, :update, :destroy]

      resources :users, only: [:index, :show, :create, :edit, :update, :destroy] do 
        resources :jobs, only: [:show]
      end

      resources :customers, only: [:index, :show, :create, :edit, :update, :destroy] do 
        get '/customer_jobs/', :to => "customers#customer_jobs", as: 'customer_jobs'
      end
      get '/jobs/:id/send_confirm_availability/', :to => "jobs#send_confirm_availability", as: 'send_confirm_availability'
      get '/jobs/:id/send_an_follow_up/', :to => "jobs#send_an_follow_up", as: 'send_an_follow_up'
      get '/jobs/:id/send_moving_confirmation/', :to => "jobs#send_moving_confirmation", as: 'send_moving_confirmation'
      get '/jobs/:id/send_permit_information/', :to => "jobs#send_permit_information", as: 'send_permit_information'
      get '/jobs/:id/send_survival_box_information/', :to => "jobs#send_survival_box_information", as: 'send_survival_box_information'
      get '/jobs/:id/send_next_day_move_reminder/', :to => "jobs#send_next_day_move_reminder", as: 'send_next_day_move_reminder'
      get '/jobs/:id/send_moving_receipt/', :to => "jobs#send_moving_receipt", as: 'send_moving_receipt'
      get '/jobs/:id/ask_for_review/', :to => "jobs#ask_for_review", as: 'ask_for_review'
      get '/jobs/:id/deposit_paid/', :to => "jobs#deposit_paid", as: 'deposit_paid'
      get '/search_reviews', :to => "jobs#search_reviews", as: 'search_reviews'
      resources :rates
      resources :prices
      resources :galleries
      resources :images, only: [:index, :show, :create, :destroy]
      resources :receipts, only: [:index, :show, :create, :destroy]
      resources :addresses, only: [:index, :show, :create, :edit, :update, :destroy]
    end
  end

  get '*path', to: "application#fallback_index_html", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end

end
