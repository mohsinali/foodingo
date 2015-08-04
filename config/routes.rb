Rails.application.routes.draw do  
  resources :restaurants, :dishes
  root to: 'restaurants#index'
  # devise_for :users
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  resources :users

  resources :restaurants do
    resources :dishes
  end

  resources :analytics do
  	collection do
      get :dish_frequency
  	end
  end

end
