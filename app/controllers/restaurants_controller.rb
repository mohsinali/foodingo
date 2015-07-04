class RestaurantsController < ApplicationController
  before_action :authenticate_user!

  PARSE_CLASS_NAME = "cafedb"

  include ParseApi

  def index
    @restaurants = get_restaurants current_user
  end

  def show
    @restaurant = Restaurant.get_restaurant params[:id]
    @dishes = Restaurant.dishes @restaurant["objectId"]
  end

  def create
    create_restaurant params[:restaurant], current_user
    
    redirect_to restaurants_path, notice: "Your restaurant has been added successfully."
  end
end
