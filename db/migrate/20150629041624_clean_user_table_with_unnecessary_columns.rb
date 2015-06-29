class CleanUserTableWithUnnecessaryColumns < ActiveRecord::Migration
  def change
  	remove_column :users, :api_key
  	remove_column :users, :passcode
  end
end
