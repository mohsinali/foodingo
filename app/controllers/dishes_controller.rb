class DishesController < ApplicationController
  before_action :authenticate_user!

  def new
    @rst = Restaurant.get_restaurant params[:restaurant_id]
    @rst = @rst.first
  end

  def create
    dish_attributes = params["dish"]
    Dish.create_dish dish_attributes

    redirect_to restaurants_path, notice: "Dish has been added successfully."
  end

end
