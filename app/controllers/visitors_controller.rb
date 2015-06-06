class VisitorsController < ApplicationController
	# Application ID: kDmDHoGKf4YGo8aCwJWqkOJbmOWtE3R2VUbeI7v0
  # Api Key: eqfkwzIh575lJWiTanlIEShH563QdiSV7cm5a6ZA

  def index
    Parse.init :application_id => "kDmDHoGKf4YGo8aCwJWqkOJbmOWtE3R2VUbeI7v0",
               :api_key        => "eqfkwzIh575lJWiTanlIEShH563QdiSV7cm5a6ZA"
    binding.pry
    user = Parse::Query.new("User")
  end
end
