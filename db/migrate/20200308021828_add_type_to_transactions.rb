class AddTypeToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :transaction_type, :string, null: false, default: "deposit"
  end
end
