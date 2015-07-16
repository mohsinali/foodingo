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
  
end
