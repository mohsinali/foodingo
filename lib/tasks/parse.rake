namespace :parse do

	desc "Fetch all mealhistory data from parse"
	task mealhistory: :environment do
    mealhistory = Parse::Query.new("mealhistory").tap do |q|
      q.limit = 1000
    end.get
    puts mealhistory.count

    # @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    MealHistory.delete_all
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE meal_histories_id_seq RESTART WITH 1")
    # @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

    mealhistory.each do |meal|
      hash = Hash.new
      hash["objectId"] = meal["objectId"]
      hash["user_id"] = meal["user_id"].to_h["objectId"]
      hash["dish_id"] = meal["dish_id"].to_h["objectId"]
      hash["merchant_id"] = meal["merchant_id"].to_h["objectId"]
      hash["cafedb_id"] = meal["cafedb_id"].to_h["objectId"]
      hash["calories"] = meal["calories"]
      hash["fat_gms"] = meal["fatgms"]
      hash["prot_gms"] = meal["prot_gms"]
      hash["carb_gms"] = meal["carb_gms"]
      hash["price"] = meal["price"]
      hash["energyKcal"] = meal["energyKcal"]
      hash["imgurl"] = meal["imgurl"]
      hash["consumption_date"] = meal["consumption_date"]
      hash["meal_historiestype"] = meal["type"]
      hash["dish"] = meal["dish"]
      hash["restaurant"] = meal["restaurant"]
      meal_obj = MealHistory.new(hash)
      meal_obj.save!
    end
      
  end
	
end