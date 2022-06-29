Rails.application.routes.draw do
  get 'welcome/index'
  root "welcome#index" , :as => 'home'
  #resources :loans, defaults: {format: :json}
 
  # constraints format: :json do
  #  resources :loans, only: [:index, :show] do
  #      resources :payments,only: [:index, :show, :create]
  #   end
  #  end
  resources :payments
  get 'payments/create', :to => 'payments#create', :as => 'create'
  get 'payments/show', :to => 'payments#show', :as => 'show'


end
