class CreateCoins < ActiveRecord::Migration[5.2]
  def change
    create_table :coins do |t|
      t.decimal :value
      t.string :name

      t.timestamps
    end
  end
end
