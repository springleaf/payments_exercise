Rails.application.routes.draw do
  resources :payments, only: [:create, :show], defaults: { format: :json }
  resources :loans, only: [:index, :show, :payments], defaults: { format: :json } do
    get :payments, on: :member
  end
end
