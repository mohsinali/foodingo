class MealHistory < ActiveRecord::Base
  MEAL_HISTORY_CLASS = "mealhistory"
  MERCHANT_CLASS = "merchants"


  def self.history parse_merchant_id
    pointer = Parse::Pointer.new({"className" => MERCHANT_CLASS, "objectId" => parse_merchant_id})
    Parse::Query.new(MEAL_HISTORY_CLASS).tap do |q|
      q.eq("merchant_id", pointer)
      q.order_by = "createdAt"
      q.order    = :ascending
    end.get
  end

  def self.dishes_frequency
    dishes_frequency = Parse::Query.new(MEAL_HISTORY_CLASS).tap do |q|
      q.exists("dish_id", true)
      q.include = "dish_id"
      q.order_by = "createdAt"
      q.order    = :ascending
    end.get

    frequency = Hash.new

    dishes_frequency.each do |d|
      if frequency.has_key? d["dish_id"]["objectId"]
        frequency[d["dish_id"]["objectId"]][1] += 1
      else
        data = []
        data << d["dish_id"]["dish"]
        data << 1

        frequency[d["dish_id"]["objectId"]] = data  
      end
      
    end
    # where={"dish_id":{"$exists":true}}&include=dish_id

  end
  
end
