class Restaurant < ActiveRecord::Base

	def self.get_restaurant objectId
		restaurant = Parse::Query.new("cafedb")
  	restaurant.eq("objectId", objectId)
		restaurant.get
	end

end
