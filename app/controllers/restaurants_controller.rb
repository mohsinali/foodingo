class RestaurantsController < ApplicationController
	before_action :authenticate_user!

	include ParseApi

	def index
		@restaurants = get_restaurants current_user
	end
end
