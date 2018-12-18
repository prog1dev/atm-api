class CreateMoney < ActiveRecord::Migration[5.2]
  def change
    create_table :money do |t|
      t.integer :value
      t.integer :count

      t.timestamps
      t.index :value, unique: true, name: :unique_index_money_on_value
    end
  end
end
