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

  def self.distance loc1str, loc2str
    loc1 = loc1str.split(',')
    loc2 = loc2str.split(',')

    loc1 = [loc1[0].to_f, loc1[1].to_f]
    loc2 = [loc2[0].to_f, loc2[1].to_f]
    
    rad_per_deg = Math::PI/180  # PI / 180
    # rmiles = 3959               # Earth Radius in miles
    rkm = 6371                # Earth radius in kilometers

    dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    rkm * c # Delta in kms
  end

end
