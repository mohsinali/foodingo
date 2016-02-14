class CreateRestaurant < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :objectId
      t.string :cafename
      t.string :cafelocation
      t.string :merchant_id
      t.string :lat
      t.string :lon
      t.float :distance
    end
  end
end
