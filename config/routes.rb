Rails.application.routes.draw do
  
  resources :bookings
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  resources :events do
    get :registered, on: :collection
    match 'events/:id' => 'events#destroy', :via => :delete, :as => :event_destroy
    resources :bookings, only: [:new, :create, :delete]
    
  end
  resources :users
  root 'home#index'
  get 'home/activity'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
