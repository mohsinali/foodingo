Rails.application.routes.draw do  
  resources :restaurants, :dishes
  root to: 'restaurants#index'
  # devise_for :users
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  resources :users


  # resources :dishes do 
  #   collection do 
  #     get :add_from_sample
  #   end 
  # end

  resources :webhooks, :none do
    collection do
      post :sync_mealhistory
    end
  end

  resources :restaurants do
    resources :dishes do
      get :add_from_sample
    end
  end

  resources :analytics do
  	collection do
      get :dish_frequency
      get :frequent_users
      post :send_push
  	end
  end

end
