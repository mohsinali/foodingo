module ParseApi
  extend ActiveSupport::Concern

  def get_restaurants user    
  	restaurants = Parse::Query.new("cafedb")
  	restaurants.eq("merchant_id", user.parse_merchant_id)
		restaurants.get
  end

  def create_restaurant rest_params, user
  	restaurant = Parse::Object.new("cafedb")
    g = Geocoder.search(rest_params[:zipcode])
    lat = g.first.data["geometry"]["location"]["lat"]
    lon = g.first.data["geometry"]["location"]["lng"]

    data ={
          "longitude" => lon,
          "latitude" => lat
        }
    point = Parse::GeoPoint.new(data)
    restaurant["cafename"] = rest_params[:cafename]
    restaurant["cafelocation"] = rest_params[:cafelocation]
    restaurant["merchant_id"] = user.parse_merchant_id
    restaurant["loc_geopoint"] = point
    restaurant.save
  end

end