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
    user_frequency = Parse::Query.new(USER_CLASS).tap do |q|
      q.eq("gender", "male")
      q.limit = 10
    end.get
  end

  def self.meal_count(user_id)
    pointer = Parse::Pointer.new({"className" => USER_CLASS, "objectId" => user_id})
    meal_history = Parse::Query.new("mealhistory").tap do |q|
      q.eq("user_id", pointer)
    end.get
    meal_history.count.to_s
  end

  private
    def creat_merchant_on_parse
      merchant = Parse::Object.new("merchants").save
            
      self.parse_merchant_id = merchant["objectId"]
    end

end
