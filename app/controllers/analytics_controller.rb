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

  def user_frequency
    @start_date = params[:start_date].present? ? params[:start_date] : (Date.today-7.days).strftime('%d/%m/%Y')
    @end_date = params[:end_date].present? ? params[:end_date] : (Date.today).strftime('%d/%m/%Y')

    @history = MealHistory.history current_user.parse_merchant_id,@start_date.to_datetime,@end_date.to_datetime

    frequency = Hash.new

    @history.each do |h|
      #hour = h["createdAt"].to_datetime.hour
      hour = h.parse_created_date.day
      if frequency.has_key? hour
        frequency[hour] = frequency[hour].to_i + 1
      else
        frequency[hour] = 1
      end
    end
    gon.y_axis = frequency.values.sort
    gon.x_axis = frequency.keys.sort #.map { |e| "%02d" % e + ":00" }
  end

  def frequent_dishes
    system "rake parse:cafedb"
    ####################################################
    @start_date = params[:start_date].present? ? params[:start_date] : (Date.today-7.days).strftime('%d/%m/%Y')
    @end_date = params[:end_date].present? ? params[:end_date] : (Date.today).strftime('%d/%m/%Y')
    ## Restaurant id is mandatory
    redirect_to restaurants_path(), notice: "Please provide a valid restaurant id." if params[:rest_id].blank?
    ####################################################

    parent_restaurant = Restaurant.where(objectId: params[:rest_id])
    
    Distance.where(parent_id: parent_restaurant.first.id).delete_all
    
    Restaurant.all.each do |r|
      dist = Restaurant.distance(parent_restaurant.first.lat.to_s + "," + parent_restaurant.first.lon.to_s, r.lat.to_s + "," + r.lon.to_s)
      puts "================= Calculated distance"
      puts dist

      if dist < 0.10  ## Only if distance is less than 100 meters
        Distance.create(parent_id: parent_restaurant.first.id, child_id: r.id, dist: dist, child_objectId: r.objectId)
      end
    end

    restaurants_in_radius = Distance.where(parent_id: parent_restaurant.first.id).order("dist desc").map &:child_objectId
    frequent_dishes_in_radius = MealHistory.where("cafedb_id IN(?) and (parse_created_date between ? and ?)", restaurants_in_radius,@start_date.to_datetime.beginning_of_day,@end_date.to_datetime.end_of_day).group(:dish_id).order("count_dish_id").limit(10).count("dish_id")
    
    dish = Parse::Query.new("mealsdummyx")
    dish.value_in('objectId', frequent_dishes_in_radius.map{|d| d[0]})
    @dishes = dish.get

    
    ds = {}
    @dishes.each do |d|
      ds[d["dish"]] = frequent_dishes_in_radius[d["objectId"]]
    end

    gon.y_axis = ds.values
    gon.x_axis = ds.keys
  end

  def dish_frequency
    @start_date = params[:start_date].present? ? params[:start_date] : (Date.today-7.days).strftime('%d/%m/%Y')
    @end_date = params[:end_date].present? ? params[:end_date] : (Date.today).strftime('%d/%m/%Y')
    @frequency = MealHistory.dishes_frequency current_user.parse_merchant_id,@start_date.to_datetime,@end_date.to_datetime
    
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
    

    pointers = []
    params[:users].each do |p|
      pointers << Parse::Pointer.new({"className" => "_User", "objectId" => p})
    end

    query = Parse::Query.new(Parse::Protocol::CLASS_INSTALLATION).value_in('user_id', pointers)
    push = Parse::Push.new(msg)
    push.where = query.where
    push.save

    redirect_to frequent_users_analytics_path(), notice: "Push notifications sent to selected users."
  end

end
