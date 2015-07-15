class DishesController < ApplicationController
  before_action :authenticate_user!

  def new
    @rst = Restaurant.get_restaurant params[:restaurant_id]
  end

  def create
    dish_attributes = params["dish"]
    Dish.create_dish dish_attributes

    redirect_to restaurant_path(id: dish_attributes["cafedb_id"]), notice: "Dish has been added successfully."
  end

end
