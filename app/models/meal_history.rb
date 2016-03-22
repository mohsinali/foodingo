class MealHistory < ActiveRecord::Base
  MEAL_HISTORY_CLASS = "mealhistory"
  MERCHANT_CLASS = "merchants"

  scope :frequent_users, ->{ group(:user_id).order('count_id desc').limit(10).count('id') }

  def self.history parse_merchant_id,start_date=(Time.now - 7.days),end_date=Time.now
    restaurants = Restaurant.where(merchant_id: parse_merchant_id)
    arr_restaurants = restaurants.map &:objectId
    mh = MealHistory.where("cafedb_id IN(?) and (parse_created_date between ? and ? )", arr_restaurants,start_date.beginning_of_day,end_date.end_of_day)    
    mh
  end

  def self.dishes_frequency parse_merchant_id,start_date=(Time.now - 7.days),end_date=Time.now
    restaurants = Restaurant.where(merchant_id: parse_merchant_id)
    arr_restaurants = restaurants.map &:objectId
    mh = MealHistory.where("cafedb_id IN(?) and (parse_created_date between ? and ? )", arr_restaurants,start_date.beginning_of_day,end_date.end_of_day).group(:dish_id).count(:dish_id)
    dishes = mh.map{|m| m.first}
    ds = Dish.get_dishes(dishes)

    frequency = {}
    ds.each do |d|
      frequency[d["dish"]] = mh[d["objectId"]]
    end

    frequency
  end
  
end
