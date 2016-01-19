class AnalyticsController < ApplicationController
  before_action :authenticate_user!

  def index    
    @history = MealHistory.history current_user.parse_merchant_id

    frequency = Hash.new
    
    @history.each do |h|
      hour = h["createdAt"].to_datetime.hour
      
      if frequency.has_key? hour
        frequency[hour] = frequency[hour].to_i + 1
      else
        frequency[hour] = 1
      end      
    end
    gon.y_axis = frequency.values.sort
    gon.x_axis = frequency.keys.sort.map { |e| "%02d" % e + ":00" }

  end

  def dish_frequency
    @frequency = MealHistory.dishes_frequency current_user.parse_merchant_id

    gon.y_axis = @frequency.values
    gon.x_axis = @frequency.keys
  end

  def frequent_users
    @f_users = User.frequent_users

    # Y2bXUUZzkC

  end

  def send_push
    binding.pry
  end

end
