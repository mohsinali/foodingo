class AddColumnMerchantLogoInUsers < ActiveRecord::Migration
  def change
    add_column :users, :merchant_logo, :string
  end
end
