class RestaurantsController < ApplicationController
  before_action :authenticate_user!

  include ParseApi

  def index
    @restaurants = get_restaurants current_user
  end

  def create
    create_restaurant params[:restaurant], current_user
    
    redirect_to restaurants_path, notice: "Your restaurant has been added successfully."
  end
end
