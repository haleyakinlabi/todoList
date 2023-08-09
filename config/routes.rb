Rails.application.routes.draw do
  devise_for :users

  # Root route
  root "lists#index"

  # Lists routes
  resources :lists do 
    resources :items, only: [:create, :destroy, :update]
  end

end


