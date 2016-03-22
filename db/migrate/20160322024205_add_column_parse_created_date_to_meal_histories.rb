class AddColumnParseCreatedDateToMealHistories < ActiveRecord::Migration
  def change
    add_column :meal_histories, :parse_created_date, :datetime
  end
end
