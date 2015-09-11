Rails.application.routes.draw do
  resources :loans, defaults: {format: :json}
end
