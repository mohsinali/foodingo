module ParseApi
  extend ActiveSupport::Concern

  def get_restaurants user    
  	restaurants = Parse::Query.new("cafedb")
  	restaurants.eq("merchant_id", user.parse_merchant_id)
		restaurants.get
  end

  def create_restaurant rest_params, user
  	restaurant = Parse::Object.new("cafedb")
    restaurant["cafename"] = rest_params[:cafename]
    restaurant["cafelocation"] = rest_params[:cafelocation]
    restaurant["merchant_id"] = user.parse_merchant_id
    restaurant.save
  end

end