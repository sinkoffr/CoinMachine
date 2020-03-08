class AddCountToCoins < ActiveRecord::Migration[5.2]
  def change
    add_column :coins, :count, :integer, null: false, default: 0 
  end
end
