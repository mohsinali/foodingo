class AddTableMealHistory < ActiveRecord::Migration
 	def change
		create_table(:meal_histories) do |t|
		  t.string :objectId
		  t.string :dish_id
		  t.string :calories
		  t.float :fat_gms
		  t.float :price
		  t.float :energyKcal
		  t.string :imgurl
		  t.string :user_id
		  t.datetime :consumption_date
		  t.string  :merchant_id
		  t.float :prot_gms
		  t.string :dish
		  t.string :meal_historiestype
		  t.float :carb_gms
		  t.string :restaurant
		  t.string :cafedb_id

		  t.timestamps
		end
	end
end
