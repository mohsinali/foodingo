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

  def edit
    @restaurant = Restaurant.get_restaurant params[:id]
  end

  def create
    create_restaurant params[:restaurant], current_user
    
    redirect_to restaurants_path, notice: "Your restaurant has been added successfully."
  end

  def update
    @restaurant = Restaurant.get_restaurant params[:id]
    restaurant = params["restaurant"]
    @restaurant["cafename"] = restaurant["cafename"]
    @restaurant["cafelocation"] = restaurant["cafelocation"]

    result = @restaurant.save
    puts result

    redirect_to restaurants_path(id: restaurant["id"])
  end

  def sync
    system "rake parse:mealhistory"
    redirect_to restaurants_path, notice: "Syncing completed."
  end
end
