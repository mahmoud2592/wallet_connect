Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :saved_entries, only: [:create, :destroy]

  resources :wallets do
    member do
      get 'connect_to_wallet'
    end
    resources :transactions, only: [:index, :create]
    resources :currency_amounts, only: [:create, :destroy]
  end
end
