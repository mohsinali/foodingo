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
	pointer = Parse::Pointer.new({"className" => RESTAURANT_CLASS_NAME, "objectId" => restaurant_objectid})
	dishes.eq("cafedb_id", pointer)
    dishes.get
	end

end
