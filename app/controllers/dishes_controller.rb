class DishesController < ApplicationController
  before_action :authenticate_user!

  def new
    @rst = Restaurant.get_restaurant params[:restaurant_id]
  end

  def show
    @dish = Dish.get_dish params[:id]
  end

  def create
    uploader = DishImageUploader.new
    a = uploader.store!(params["dish_image"])    

    dish_attributes = params["dish"]
    dish_attributes["imgurl"] = uploader.url
    Dish.create_dish dish_attributes

    redirect_to restaurant_path(id: dish_attributes["cafedb_id"]), notice: "Dish has been added successfully."
  end

end
