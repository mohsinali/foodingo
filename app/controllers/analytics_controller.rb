class AnalyticsController < ApplicationController
  before_action :authenticate_user!

  def index
    @history = MealHistory.history

    frequency = Hash.new
    @history.each do |h|
      hour = h["createdAt"].to_datetime.hour
      if frequency.has_key? hour
        frequency[hour] = frequency[hour].to_i + 1
      else
        frequency[hour] = 1
      end      
    end

    gon.keys = frequency.keys.sort.map { |e| "%02d" % e + ":00" }

  end

end
