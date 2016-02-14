class CreateDistances < ActiveRecord::Migration
  def change
    create_table :distances do |t|
      t.integer :parent_id
      t.integer :child_id
      t.float :dist
      t.string :child_objectId

      t.timestamps null: false
    end
  end
end
