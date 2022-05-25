Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :trips do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:show, :edit, :update]

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  get "trips/:id/booked", to: "trips#booked", as: :booked
end
