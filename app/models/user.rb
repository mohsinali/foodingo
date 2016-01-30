class User < ActiveRecord::Base
  rolify
  after_initialize :set_default_role, :if => :new_record?
  before_create :creat_merchant_on_parse

  USER_CLASS = "_User"

  # has_many :categories, :class_name => "Category", :foreign_key => "restaurant_owner_id"
  # has_many :menus, :class_name => "Menu", :foreign_key => "restaurant_owner_id"
  # has_many :device_table_mappings, :class_name => "DeviceTableMapping", :foreign_key => "restaurant_owner_id"

  def set_default_role
    self.add_role :merchant
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ####################################
  ## Parse Queries
  def self.frequent_users
    # MealHistory.group(:user_id).order('count_id desc').limit(10).count('id')
    # binding.pry
    # user_ids = []
    # top_meals.each do |user_id, count|
    #   user_ids.push(user_id)
    # end
    # user_objs = []
    # user_ids.each do |user|
    #   user_frequency = Parse::Query.new("_User").tap do |q|
    #     q.eq("objectId", user)
    #   end.get
    #   unless user_frequency.blank?
    #     user_frequency.first["count"] = top_meals[user_frequency.first["objectId"]]
    #     user_objs.push(user_frequency.first)
    #   end
    # end
    # return user_objs
  end

  private
    def creat_merchant_on_parse
      merchant = Parse::Object.new("merchants").save
            
      self.parse_merchant_id = merchant["objectId"]
    end

end
