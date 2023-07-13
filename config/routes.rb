Rails.application.routes.draw do
  resources :loans, defaults: {format: :json}
  resources :payments, only: [:create]
end
