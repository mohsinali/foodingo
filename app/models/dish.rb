class Dish < ActiveRecord::Base
	DISHES_CLASS_NAME = "mealsdummyx"
  RESTAURANT_CLASS_NAME = "cafedb"

	def self.create_dish dish_attributes
    pointer = Parse::Pointer.new({"className" => RESTAURANT_CLASS_NAME, "objectId" => dish_attributes["cafedb_id"]})

		dish = Parse::Object.new(DISHES_CLASS_NAME)
		dish["dish"] = dish_attributes["name"]
		dish["price"] = dish_attributes["price"].to_i
		dish["cafedb_id"] = pointer
    dish["description"] = dish_attributes["description"]
    dish["imgurl"] = dish_attributes["imgurl"]

		dish.save
	end

  def self.create_from_sample sample_dish, parse_restaurant_id    
    dish = Parse::Object.new(DISHES_CLASS_NAME)
    pointer = Parse::Pointer.new({"className" => RESTAURANT_CLASS_NAME, "objectId" => parse_restaurant_id})
    sample_dish.each do |key, value|
      dish[key] = value unless key.eql? "objectId"
    end
    dish["cafedb_id"] = pointer
    
    dish.save
  end

  def self.get_dish objectId
    dish = Parse::Query.new(DISHES_CLASS_NAME)
    dish.eq("objectId", objectId)
    dish.get.first
  end

  def self.delete_dish objectId
    dish = Parse::Query.new(DISHES_CLASS_NAME)
    dish.eq("objectId", objectId)
    dish.get.first.parse_delete
  end

end
