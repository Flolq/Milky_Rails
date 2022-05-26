Rails.application.routes.draw do
  devise_for :users
  root to: 'trips#index'

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    resources :trips, only: [:new, :create]
  end
  resources :trips, except: [:new, :create] do
    resources :bookings, only: [:create]
  end

  resources :bookings, only: [:show, :edit, :update]


  get "trips/:id/booked", to: "trips#booked", as: :booked
end
