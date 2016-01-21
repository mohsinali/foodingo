class SampleDish < ActiveRecord::Base
  SAMPLE_DISH_CLASS_NAME = "sample_dishes"

  def self.get_dishes
    dishes = Parse::Query.new(SAMPLE_DISH_CLASS_NAME)

    dishes.get
  end

  def self.get_dish objectId
    dish = Parse::Query.new(SAMPLE_DISH_CLASS_NAME)
    dish.eq("objectId", objectId)
    dish.get.first
  end

  def self.create_dish dish_attributes
    dish = Parse::Object.new(SAMPLE_DISH_CLASS_NAME)
    dish_attributes.each do |key, value|
      dish[key] = value unless key.eql? "objectId"
    end
    
    dish.save
  end

end
