Rails.application.routes.draw do
  resources :payments
  resources :loans, defaults: {format: :json}
end
