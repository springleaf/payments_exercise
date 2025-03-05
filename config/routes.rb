Rails.application.routes.draw do
  resources :loans, only: [:index, :show] do
    resources :payments, only: [:index, :create, :show]
  end
end