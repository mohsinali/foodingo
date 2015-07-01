class DishesController < ApplicationController
	before_action :authenticate_user!

	def new
		@rst = Restaurant.get_restaurant params[:restaurant_id]
		@rst = @rst.first
	end
end
