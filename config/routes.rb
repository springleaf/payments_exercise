Rails.application.routes.draw do
  #resources :loans, defaults: {format: :json}
  constraints format: :json do
   resources :loans, only: [:index, :show] do
       resources :payments,only: [:index, :show, :create]
    end
   end
end
