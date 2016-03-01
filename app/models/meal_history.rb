class MealHistory < ActiveRecord::Base
  MEAL_HISTORY_CLASS = "mealhistory"
  MERCHANT_CLASS = "merchants"

  scope :frequent_users, ->{ group(:user_id).order('count_id desc').limit(10).count('id') }


  def self.history parse_merchant_id
    pointer = Parse::Pointer.new({"className" => MERCHANT_CLASS, "objectId" => parse_merchant_id})
    Parse::Query.new(MEAL_HISTORY_CLASS).tap do |q|
      q.eq("merchant_id", pointer)
      q.order_by = "createdAt"
      q.order    = :ascending
    end.get
  end

  def self.dishes_frequency parse_merchant_id
    restaurants = Restaurant.where(merchant_id: parse_merchant_id)
    arr_restaurants = restaurants.map &:objectId
    mh = MealHistory.where("cafedb_id IN(?)", arr_restaurants).group(:dish_id).count(:dish_id)
    dishes = mh.map{|m| m.first}
    ds = Dish.get_dishes(dishes)

    frequency = {}
    ds.each do |d|
      frequency[d["dish"]] = mh[d["objectId"]]
    end

    frequency
  end
  
end
