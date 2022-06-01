Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/dashboard", to: "pages#dashboard", as: :dashboard
  resources :patients, only: [:show, :new, :create, :update, :edit, :index] do
    resources :medical_records, only: [:index, :new, :create, :edit, :update, :destroy, :show]
    member do
      patch "autofill"
    end
  end
  resources :doctors, only: [:show, :new, :create, :update, :edit] do
    resources :medical_records, only: [:index, :new, :create, :edit, :update, :destroy, :show]
  end
  resources :events, only: [:index, :show, :new, :create, :update, :edit, :destroy]
  get "calendar", to: "pages#calendar", as: "calendar"
  get "/map", to: "pages#map", as: "map", as: "map"
end
