class RenameMoneyTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :money, :bills
    rename_index :bills, :unique_index_money_on_value, :unique_index_bills_on_denomination
  end
end
