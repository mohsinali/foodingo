class MealHistory < ActiveRecord::Base
  MEAL_HISTORY_CLASS = "mealhistory"


  def self.history
    Parse::Query.new(MEAL_HISTORY_CLASS).tap do |q|
      q.order_by = "createdAt"
      q.order    = :ascending
    end.get
  end
  
end
