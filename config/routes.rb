Rails.application.routes.draw do
  resources :loans, defaults: {format: :json}, only: [:index, :show] do
    resources :payments, defaults: {format: :json}, only: [:index, :show, :create]
  end
end
