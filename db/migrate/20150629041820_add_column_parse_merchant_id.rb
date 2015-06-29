class AddColumnParseMerchantId < ActiveRecord::Migration
  def change
  	add_column :users, :parse_merchant_id, :string
  end
end
