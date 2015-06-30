module ParseApi
  extend ActiveSupport::Concern

  def get_restaurants user
  	restaurants = Parse::Query.new("cafedb")
  	restaurants.eq("merchant_id", user.parse_merchant_id)
		restaurants.get
  end

end