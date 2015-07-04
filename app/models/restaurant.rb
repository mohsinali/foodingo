class Restaurant < ActiveRecord::Base

	RESTAURANT_CLASS_NAME = "cafedb"
	DISHES_CLASS_NAME = "mealsdummyx"

	def self.get_restaurant objectId
		restaurant = Parse::Query.new(RESTAURANT_CLASS_NAME)
    restaurant.eq("objectId", objectId)
    restaurant.get.first
	end

	def self.dishes restaurant_objectid
		dishes = Parse::Query.new(DISHES_CLASS_NAME)
    dishes.eq("cafedb_id", restaurant_objectid)
    dishes.get
	end

end
