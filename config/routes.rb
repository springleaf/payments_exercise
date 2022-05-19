Rails.application.routes.draw do
  resources :loans, defaults: {format: :json}
  resources :payments, defaults: {format: :json}
end
