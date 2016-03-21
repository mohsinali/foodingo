Rails.application.routes.draw do  
  resources :dishes
  root to: 'restaurants#index'
  # devise_for :users
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  resources :users do 
    collection do
      get :settings
      post :upload_logo
    end
  end


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
    collection do
      get :sync
    end
    resources :dishes do
      get :add_from_sample      
    end
  end

  resources :analytics do
  	collection do
      get :dish_frequency
      post :dish_frequency
      get :frequent_users
      post :send_push
      get '/frequent_dishes/:rest_id' => 'analytics#frequent_dishes', as: :frequent_dishes
  	end
  end

end
