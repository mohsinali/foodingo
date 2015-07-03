class Dish < ActiveRecord::Base
	PARSE_CLASS_NAME = "mealsdummyx"

	def self.create_dish dish_attributes
		dish = Parse::Object.new(PARSE_CLASS_NAME)
		dish["dish"] = dish_attributes["name"]
		dish["price"] = dish_attributes["price"].to_i
		dish["cafedb_id"] = dish_attributes["cafedb_id"]
		dish.save
	end

end
