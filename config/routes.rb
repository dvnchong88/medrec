Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/dashboard", to: "patients#dashboard", as: :dashboard

  resources :patients, only: :create do
    resources :medical_records, only: [:index, :new, :create, :edit, :update, :destroy ]
  end
end
