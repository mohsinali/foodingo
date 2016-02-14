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

  def frequent_dishes
    ####################################################
    ## Restaurant id is mandatory
    redirect_to restaurants_path(), notice: "Please provide a valid restaurant id." if params[:rest_id].blank?
    ####################################################

    parent_restaurant = Restaurant.where(objectId: params[:rest_id])
    Distance.where(parent_id: parent_restaurant.first.id).delete_all
    
    Restaurant.all.each do |r|
      dist = Restaurant.distance(parent_restaurant.first.lat.to_s + "," + parent_restaurant.first.lon.to_s, r.lat.to_s + "," + r.lon.to_s)
      puts "================= Calculated distance"
      puts dist

      if dist < 0.06  ## Only if distance is less than 60 meters
        Distance.create(parent_id: parent_restaurant.first.id, child_id: r.id, dist: dist, child_objectId: r.objectId)
      end
    end


  end

  def dish_frequency
    @frequency = MealHistory.dishes_frequency current_user.parse_merchant_id

    gon.y_axis = @frequency.values
    gon.x_axis = @frequency.keys
  end

  def frequent_users
    @f_users = MealHistory.frequent_users    

  end

  def send_push
    msg = { :push_type => 'Message',
      :aps => { 
        :alert => params[:send_push][:message],
        :sound => "default"
      }
    }

    query = Parse::Query.new(Parse::Protocol::CLASS_INSTALLATION).value_in('user_id', params[:users])
    push = Parse::Push.new(msg)
    push.where = query.where
    push.save

    redirect_to frequent_users_analytics_path(), notice: "Push notifications sent to selected users."
  end

end
