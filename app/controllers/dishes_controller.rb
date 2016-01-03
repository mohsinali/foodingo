class DishesController < ApplicationController
  before_action :authenticate_user!

  def new
    @rst = Restaurant.get_restaurant params[:restaurant_id]
  end

  def show
    @dish = Dish.get_dish params[:id]
  end

  def edit
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

  def update
    @dish = Dish.get_dish params[:id]
    dish = params["dish"]
    @dish["name"] = dish["name"]
    @dish["price"] = dish["price"].to_f
    @dish["description"] = dish["description"]

    if params[:dish_image].present?
      uploader = DishImageUploader.new
      uploader.store!(params["dish_image"])
      @dish["imgurl"] = uploader.url
    end

    result = @dish.save
    puts result
    redirect_to dish_path(id: params["id"]), notice: "Dish has been updated successfully."
  end

  def destroy
    begin
      Dish.delete_dish(params[:id])
    rescue Exception => e
      puts "## ============ Exception =========== ##"
      puts e.message
    end

    redirect_to restaurant_path(id: params["restaurant_id"]), notice: "Dish has been deleted successfully."
  end

end
