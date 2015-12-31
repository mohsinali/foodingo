class Dish < ActiveRecord::Base
	DISHES_CLASS_NAME = "mealsdummyx"

	def self.create_dish dish_attributes
		dish = Parse::Object.new(DISHES_CLASS_NAME)
		dish["dish"] = dish_attributes["name"]
		dish["price"] = dish_attributes["price"].to_i
		dish["cafedb_id"] = dish_attributes["cafedb_id"]
    dish["description"] = dish_attributes["description"]
    dish["imgurl"] = dish_attributes["imgurl"]

		dish.save
	end

  def self.get_dish objectId
    dish = Parse::Query.new(DISHES_CLASS_NAME)
    dish.eq("objectId", objectId)
    dish.get.first
  end

end
